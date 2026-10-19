/**
 * @file main.c
 * @brief Continuous double-buffered waveform scheduler and lifecycle engine for NY8B062F.
 */

#include <ny8.h>
#include "ny8_constant.h"
#include "waveform_perfect_model_gemini.h"

#define PIN_MASK_PA0_POWER_HOLD       ((uint8_t)(1U << 0))
#define PIN_MASK_PA2_PWM3             ((uint8_t)(1U << 2))
#define PIN_MASK_PA4_UNUSED           ((uint8_t)(1U << 4))
#define PIN_MASK_PA5_RED_LED          ((uint8_t)(1U << 5))
#define PIN_MASK_PA7_GREEN_LED        ((uint8_t)(1U << 7))

#define TIMER2_CHUNK_STEPS            50U
#define MODEL_ID_MOVANO_LOCAL          ((uint8_t)MODEL_ID_STANDARD_COUNT)
#define MODEL_ID_VIBE_LOCAL            ((uint8_t)(MODEL_ID_STANDARD_COUNT + 1U))

/**
 * @brief Playback modes for schedule entries.
 */
typedef enum
{
    PLAY_MODE_REPEAT_MODEL = 0,    /**< Repeat canonical model stages until entry duration expires. */
    PLAY_MODE_CONTINUOUS_CARRIER,  /**< Emit continuous unmodulated carrier. */
    PLAY_MODE_SILENCE,             /**< Inhibit carrier output entirely. */
    PLAY_MODE_C10,                 /**< Emit single complete C10 composite sequence then silence. */
    PLAY_MODE_ONESHOT_MODEL        /**< Emit model stages exactly once, then advance on completion. */
} play_mode_t;

/**
 * @brief Result of advancing the active entry to its next waveform stage.
 */
typedef enum
{
    STAGE_SELECT_NONE = 0,         /**< No successor exists for the active entry. */
    STAGE_SELECT_READY,            /**< Stage timing is already available in the remainder state. */
    STAGE_SELECT_STANDARD          /**< Standard-model stage requires sequential ROM decoding. */
} stage_select_result_t;

/* Three ROM bytes per entry:
 * [0] duration in 200 ms units (20 Timer1 ticks)
 * [1] bits7:6 packed mode, bit5 CP1, bits4:0 model ID
 * [2] stage count for REPEAT/ONESHOT, otherwise 0 */
#define PLAYLIST_MODE_REPEAT          0x00U
#define PLAYLIST_MODE_ONESHOT         0x40U
#define PLAYLIST_MODE_PASSIVE         0x80U
#define PLAYLIST_MODE_C10             0xC0U
#define PLAYLIST_MODE_MASK            0xC0U
#define PLAYLIST_CP1                  0x20U
#define PLAYLIST_MODEL_MASK           0x1FU
#define PLAYLIST_ITEM_BYTES           3U
#define PLAYLIST_ITEM_COUNT           20U

static const uint8_t __code c_playlist[] =
{
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | PLAYLIST_CP1 | MODEL_ID_MOVANO_LOCAL),              88U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | PLAYLIST_CP1 | MODEL_ID_VIBE_LOCAL),                 7U,
    10U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_P0),                              64U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C1),                              63U,
    25U, (uint8_t)(PLAYLIST_MODE_PASSIVE | PLAYLIST_CP1),                                       0U,
     6U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C3_PREFIX),                       49U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C3_BODY),                         60U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C4),                              63U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C5),                              43U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C6),                              63U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C7),                              63U,
     5U, (uint8_t) PLAYLIST_MODE_PASSIVE,                                                        0U,
     5U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C8_A),                            77U,
     0U, (uint8_t)(PLAYLIST_MODE_ONESHOT | (uint8_t)MODEL_ID_C9_PREAMBLE_INIT),                52U,
    10U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C9_PREAMBLE),                     41U,
     0U, (uint8_t)(PLAYLIST_MODE_ONESHOT | (uint8_t)MODEL_ID_C9_MAIN_INIT),                    69U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C9_MAIN),                         42U,
    10U, (uint8_t) PLAYLIST_MODE_PASSIVE,                                                        0U,
    25U, (uint8_t)(PLAYLIST_MODE_C10     | PLAYLIST_CP1),                                       0U,
    25U, (uint8_t)(PLAYLIST_MODE_REPEAT  | (uint8_t)MODEL_ID_C11),                             55U
};

/* Authoritative state shared between foreground and ISR */
static volatile uint16_t s_entry_timer_10ms;
static volatile uint8_t  s_entry_index;
static volatile uint8_t  s_entry_expired;
static volatile uint8_t  s_running;

/* RAM entry snapshots: written ONLY by load_playlist_entry() while interrupts are disabled */
static volatile uint8_t  s_current_entry_mode;
static volatile uint8_t  s_current_model_id;
static volatile uint8_t  s_current_stage_count;

/* Interval pipeline state (owned and written by ISR; seeded/cleared by load_playlist_entry in critical section) */
static uint16_t s_active_rem;         /**< Active carrier steps remaining to queue for current stage. */
static uint16_t s_inactive_rem;       /**< Inactive steps remaining to queue for current stage. */
static uint8_t  s_current_phase;      /**< Running phase: 1 = active (carrier ON), 0 = inactive (carrier OFF). */
static uint8_t  s_queued_phase;       /**< Queued phase in Timer2 double buffer: 1 = active, 0 = inactive. */
static uint8_t  s_has_queued_chunk;   /**< 1 = valid chunk queued in hardware double buffer; 0 = end of stream. */

/* Prepared-follow state for P=2 atomic active/inactive pair (transport ownership) */
static uint8_t  s_prep_inactive_steps; /**< Validity-bearing step count: nonzero = prepared chunk reserved; 0 = none. */
static uint8_t  s_prep_tmrh;           /**< Precomputed TMRH reload byte for the prepared inactive chunk. */
static uint8_t  s_prep_tmr2;           /**< Precomputed TMR2 reload byte for the prepared inactive chunk. */

/* Stage progression state */
static uint8_t  s_stage_index;        /**< Stage cursor for REPEAT and ONESHOT models. */
static uint8_t  s_c10_phase;          /**< C10 sequence phase: 0: Body, 1: Tail, 2: Special, 3: Done. */
static uint8_t  s_c10_round;          /**< C10 Body round counter [0..8]. */
static uint8_t  s_c10_stage;          /**< Stage cursor within active C10 phase. */
static uint8_t  s_red_blink_ticks;     /**< 10 ms ticks for low-voltage red LED blinking. */

/* Forward declarations */
static void pwm3_set_enabled(bool enabled);
static void timer2_queue_interval(uint8_t steps);
static stage_select_result_t select_next_stage(uint8_t *out_standard_stage_index);
static uint8_t determine_next_chunk(void);
static void load_playlist_entry(uint8_t index);
static void service_timer2_underflow(void);

/**
 * @brief Configure GPIO direction, pull-up, and initial pin states.
 */
static void gpio_init(void)
{
    APHCON = (uint8_t)~C_PA0_PHB;
    IOSTA = C_PA7_Output | C_PA5_Output | C_PA4_Input | C_PA2_Output | C_PA0_Output;
    PORTA = (PIN_MASK_PA5_RED_LED | PIN_MASK_PA0_POWER_HOLD);

    IOSTB = C_PB3_Input;
    PORTB = 0x08U;
}

/**
 * @brief Disable unused legacy Timer0 and ADC peripherals.
 */
static void legacy_peripherals_disable(void)
{
    PCONbits.LVDEN = 1;
    PCON1 = (uint8_t)(C_TMR0_Dis | C_LVD_3P6V);
    ADMD = 0x00U;
    ADRbits.ADIE = 0;
    ADRbits.ADIF = 0;
}

/**
 * @brief Configure Timer3/PWM3 carrier generator.
 */
static void pwm3_init(void)
{
    TM3RH = 0x00U;
    TMR3 = 79U;         /* 80 instruction cycles = 8 us period (125 kHz) */
    PWM3DUTY = 25U;     /* Default CP2 active cycles */
    T3CR2 = C_PS3_Dis | C_TMR3_ClkSrc_Inst;
    T3CR1 = C_PWM3_Active_Hi | C_TMR3_Reload | C_TMR3_En;
    PORTA &= (uint8_t)~PIN_MASK_PA2_PWM3;
}

/**
 * @brief Enable or disable PWM3 carrier output on PA2.
 * @param[in] enabled true to emit carrier; false to force low output.
 */
static void pwm3_set_enabled(bool enabled)
{
    if (enabled)
    {
        T3CR1 |= C_PWM3_En;
    }
    else
    {
        T3CR1 &= (uint8_t)~C_PWM3_En;
        PORTA &= (uint8_t)~PIN_MASK_PA2_PWM3;
    }
}

/**
 * @brief Configure Timer1 as a 10 ms periodic tick down-counter.
 */
static void timer1_init(void)
{
    /* 10 MHz / 128 = 78,125 Hz. 781 counts down to 0 = 9.9968 ms ~ 10 ms.
     * Timer1 is a DOWN-COUNTER. Reload value must be 781 (0x030D).
     * High 2 bits: C_TMR1_Data_b9 | C_TMR1_Data_b8 = 0x0300 (768).
     * Low 8 bits: TMR1 = 13 (0x0D). Total = 768 + 13 = 781.
     */
    TMRH = (C_TMR1_Data_b9 | C_TMR1_Data_b8);
    TMR1 = 0x0DU;
    INTFbits.T1IF = 0;
    T1CR2 = C_TMR1_ClkSrc_Inst | C_PS1_EN | C_PS1_Div128;
    T1CR1 = C_TMR1_Reload | C_TMR1_En;
}

/**
 * @brief Configure Timer2 for 0.4 us count resolution (inst clock / 4).
 */
static void timer2_init(void)
{
    T2CR1 = 0x00U;
    T2CR2 = C_TMR2_ClkSrc_Inst | C_PS2_EN | C_PS2_Div4;
    INTFbits.T2IF = 0;
}

/**
 * @brief Configure interrupt mask for watchdog, Timer1, and Timer2.
 */
static void interrupt_init(void)
{
    INTF = 0x00U;
    INTE = C_INT_WDT | C_INT_TMR1 | C_INT_TMR2;
}

/**
 * @brief Queue the following interval into the Timer2 double buffer while running.
 * @param[in] steps Step count in range [1, 50].
 * @note Writes TMRH/TMR2 only; valid for a running double buffer or a stopped initial seed.
 */
static void timer2_queue_interval(uint8_t steps)
{
    uint16_t reload = (uint16_t)(((uint16_t)steps << 4) + ((uint16_t)steps << 2) - 1U);
    uint8_t tmrh_val = 0U;

    if ((reload & 0x0200U) != 0U)
    {
        tmrh_val |= C_TMR2_Data_b9;
    }
    if ((reload & 0x0100U) != 0U)
    {
        tmrh_val |= C_TMR2_Data_b8;
    }

    TMRH = tmrh_val;
    TMR2 = (uint8_t)reload;
}

/**
 * @brief Advance the active entry and select its next waveform stage.
 * @param[out] out_standard_stage_index Selected index when STAGE_SELECT_STANDARD is returned.
 * @return Selection result describing whether the stage ended, is ready, or needs standard decoding.
 * @note Standard-model ROM decoding must occur after this function returns.
 */
static stage_select_result_t select_next_stage(uint8_t *out_standard_stage_index)
{
    uint8_t mode = s_current_entry_mode;

    if (mode == (uint8_t)PLAY_MODE_REPEAT_MODEL)
    {
        if (s_current_stage_count == 0U)
        {
            return STAGE_SELECT_NONE;
        }
        if (s_stage_index >= s_current_stage_count)
        {
            s_stage_index = 0U;
        }

        *out_standard_stage_index = s_stage_index;
        s_stage_index++;
        if (s_stage_index >= s_current_stage_count)
        {
            s_stage_index = 0U;
        }
        return STAGE_SELECT_STANDARD;
    }

    if (mode == (uint8_t)PLAY_MODE_ONESHOT_MODEL)
    {
        if (s_stage_index < s_current_stage_count)
        {
            *out_standard_stage_index = s_stage_index;
            s_stage_index++;
            return STAGE_SELECT_STANDARD;
        }
        else
        {
            return STAGE_SELECT_NONE;
        }
    }

    if (mode == (uint8_t)PLAY_MODE_C10)
    {
        bool has_next = false;

        if (s_c10_phase == 0U)
        {
            /* 9 rounds of 26-slot Body (234 stages, slots 0..25) */
            has_next = waveform_model_load_c10_stage(0U, s_c10_stage);
            s_c10_stage++;
            if (s_c10_stage >= 26U)
            {
                s_c10_stage = 0U;
                s_c10_round++;
                if (s_c10_round >= 9U)
                {
                    s_c10_phase = 1U; /* Transition to Tail */
                }
            }
        }
        else if (s_c10_phase == 1U)
        {
            /* 14 slots of Tail (slots 0..13) */
            has_next = waveform_model_load_c10_stage(1U, s_c10_stage);
            s_c10_stage++;
            if (s_c10_stage >= 14U)
            {
                s_c10_phase = 2U; /* Transition to Special Events */
                s_c10_stage = 0U;
            }
        }
        else if (s_c10_phase == 2U)
        {
            /* 7 slots of Special Events (slots 0..6) */
            has_next = waveform_model_load_c10_stage(2U, s_c10_stage);
            s_c10_stage++;
            if (s_c10_stage >= 7U)
            {
                s_c10_phase = 3U; /* Sequence complete */
            }
        }

        if (has_next)
        {
            s_active_rem = g_stage_on_steps;
            s_inactive_rem = g_stage_off_steps;
            return STAGE_SELECT_READY;
        }
        else
        {
            return STAGE_SELECT_NONE;
        }
    }

    return STAGE_SELECT_NONE;
}

/**
 * @brief Determine the next chunk duration and phase from stage remainders.
 * @return Encoded byte: 0 if no steps remain; otherwise bit 7 is phase (1=active, 0=inactive)
 *         and bits 0..5 are step count in [1, 50].
 * @note Implements Section 7.3 deadline-safe partition rule using comparisons, subtraction,
 *       and right shift. Contains no callable children, division, modulo, or pointers.
 */
static uint8_t determine_next_chunk(void)
{
    uint8_t chunk;
    uint16_t rem;

    if (s_active_rem > 0U)
    {
        rem = s_active_rem;
    }
    else if (s_inactive_rem > 0U)
    {
        rem = s_inactive_rem;
    }
    else
    {
        return 0U;
    }

    if (rem <= 50U)
    {
        chunk = (uint8_t)rem;
    }
    else if (rem <= 74U)
    {
        chunk = (uint8_t)(rem >> 1);
    }
    else if (rem <= 100U)
    {
        chunk = (uint8_t)(rem - 50U);
    }
    else
    {
        chunk = 50U;
    }

    if (s_active_rem > 0U)
    {
        s_active_rem -= chunk;
        return (uint8_t)(0x80U | chunk);
    }

    s_inactive_rem -= chunk;
    return chunk;
}

/**
 * @brief Initialize and start a playlist entry from a quiescent state.
 * @note Must be called with global interrupts disabled.
 */
static void load_playlist_entry(uint8_t index)
{
    stage_select_result_t select_result;
    uint8_t standard_stage_index;
    uint8_t entry_offset;
    uint8_t duration_code;
    uint8_t control;
    uint8_t mode_code;
    uint8_t first_encoded;
    uint8_t first_phase;
    uint8_t first_chunk;
    uint8_t queued_encoded;
    uint8_t queued_phase;
    uint8_t queued_chunk;

    entry_offset = (uint8_t)((index << 1) + index);
    duration_code = c_playlist[entry_offset];
    control = c_playlist[entry_offset + 1U];

    T2CR1 = C_TMR2_Dis;
    INTFbits.T2IF = 0;
    s_active_rem = 0U;
    s_inactive_rem = 0U;
    s_current_phase = 0U;
    s_queued_phase = 0U;
    s_has_queued_chunk = 0U;
    s_prep_inactive_steps = 0U;
    s_prep_tmrh = 0U;
    s_prep_tmr2 = 0U;
    s_current_entry_mode = (uint8_t)PLAY_MODE_SILENCE;
    s_current_model_id = (uint8_t)(control & PLAYLIST_MODEL_MASK);
    s_current_stage_count = c_playlist[entry_offset + 2U];
    s_stage_index = 0U;
    s_c10_phase = 0U;
    s_c10_round = 0U;
    s_c10_stage = 0U;
    pwm3_set_enabled(false);

    /* duration_code uses 200 ms units = 20 Timer1 ticks. */
    s_entry_timer_10ms = (uint16_t)(((uint16_t)duration_code << 4) +
                                    ((uint16_t)duration_code << 2));

    if ((control & PLAYLIST_CP1) != 0U)
    {
        PWM3DUTY = 40U;
    }
    else
    {
        PWM3DUTY = 25U;
    }

    mode_code = (uint8_t)(control & PLAYLIST_MODE_MASK);
    if (mode_code == PLAYLIST_MODE_REPEAT)
    {
        s_current_entry_mode = (uint8_t)PLAY_MODE_REPEAT_MODEL;
    }
    else if (mode_code == PLAYLIST_MODE_ONESHOT)
    {
        s_current_entry_mode = (uint8_t)PLAY_MODE_ONESHOT_MODEL;
    }
    else if (mode_code == PLAYLIST_MODE_PASSIVE)
    {
        if ((control & PLAYLIST_CP1) != 0U)
        {
            s_current_entry_mode = (uint8_t)PLAY_MODE_CONTINUOUS_CARRIER;
        }
        else
        {
            s_current_entry_mode = (uint8_t)PLAY_MODE_SILENCE;
        }
    }
    else
    {
        s_current_entry_mode = (uint8_t)PLAY_MODE_C10;
    }

    if (s_current_entry_mode == (uint8_t)PLAY_MODE_CONTINUOUS_CARRIER)
    {
        pwm3_set_enabled(true);
        return;
    }

    if (s_current_entry_mode == (uint8_t)PLAY_MODE_SILENCE)
    {
        return;
    }

    select_result = select_next_stage(&standard_stage_index);
    if (select_result == STAGE_SELECT_STANDARD)
    {
        waveform_model_load_stage(s_current_model_id, standard_stage_index);
        s_active_rem = g_stage_on_steps;
        s_inactive_rem = g_stage_off_steps;
        select_result = STAGE_SELECT_READY;
    }
    if (select_result == STAGE_SELECT_NONE)
    {
        return;
    }

    first_encoded = determine_next_chunk();
    if (first_encoded == 0U)
    {
        return;
    }

    first_phase = (uint8_t)((first_encoded & 0x80U) != 0U);
    first_chunk = (uint8_t)(first_encoded & 0x3FU);

    s_current_phase = first_phase;
    pwm3_set_enabled(first_phase != 0U);

    /* Timer2 is already stopped; program the same reload path used for queued chunks. */
    timer2_queue_interval(first_chunk);
    INTFbits.T2IF = 0;
    T2CR1 = C_TMR2_Reload | C_TMR2_En;

    queued_encoded = determine_next_chunk();
    if (queued_encoded == 0U)
    {
        select_result = select_next_stage(&standard_stage_index);
        if (select_result == STAGE_SELECT_STANDARD)
        {
            waveform_model_load_stage(s_current_model_id, standard_stage_index);
            s_active_rem = g_stage_on_steps;
            s_inactive_rem = g_stage_off_steps;
            select_result = STAGE_SELECT_READY;
        }
        if (select_result == STAGE_SELECT_READY)
        {
            queued_encoded = determine_next_chunk();
        }
    }

    if (queued_encoded > 0U)
    {
        queued_phase = (uint8_t)((queued_encoded & 0x80U) != 0U);
        queued_chunk = (uint8_t)(queued_encoded & 0x3FU);
        s_queued_phase = queued_phase;
        s_has_queued_chunk = 1U;
        timer2_queue_interval(queued_chunk);
    }
    else
    {
        s_has_queued_chunk = 0U;
    }
}

/**
 * @brief Service Timer2 underflow event in the continuous double-buffer pipeline.
 * @note Clears T2IF, rejects non-scheduled modes via RAM snapshot, and applies PWM edge
 *       before stage decoding or queue calculation.
 */
static void service_timer2_underflow(void)
{
    stage_select_result_t select_result;
    uint8_t standard_stage_index;
    uint8_t encoded;
    uint8_t next_phase;
    uint8_t next_chunk;
    uint8_t prep_encoded;
    uint8_t prep_steps;
    uint16_t reload;
    uint8_t tmrh_val;

    INTFbits.T2IF = 0;

    if (s_running == 0U)
    {
        return;
    }

    /* Reject non-scheduled modes immediately using RAM mode snapshot */
    if ((s_current_entry_mode == (uint8_t)PLAY_MODE_SILENCE) ||
        (s_current_entry_mode == (uint8_t)PLAY_MODE_CONTINUOUS_CARRIER))
    {
        return;
    }

    /* Fast path for P=2: queued 2-step active chunk is now running */
    if (s_prep_inactive_steps != 0U)
    {
        T3CR1 |= C_PWM3_En;
        s_current_phase = 1U;

        TMRH = s_prep_tmrh;
        TMR2 = s_prep_tmr2;

        s_queued_phase = 0U;
        s_has_queued_chunk = 1U;
        s_prep_inactive_steps = 0U;
        return;
    }

    /* Handle end of sequence: final inactive chunk has completely elapsed */
    if (s_has_queued_chunk == 0U)
    {
        T3CR1 &= (uint8_t)~C_PWM3_En;
        PORTA &= (uint8_t)~PIN_MASK_PA2_PWM3;
        T2CR1 = C_TMR2_Dis;
        INTFbits.T2IF = 0;
        s_prep_inactive_steps = 0U;

        if (s_current_entry_mode == (uint8_t)PLAY_MODE_ONESHOT_MODEL)
        {
            s_entry_expired = 1U;
        }
        return;
    }

    /* Apply PWM edge immediately: queued chunk is now the running chunk */
    if (s_current_phase != s_queued_phase)
    {
        s_current_phase = s_queued_phase;
        if (s_current_phase != 0U)
        {
            T3CR1 |= C_PWM3_En;
        }
        else
        {
            T3CR1 &= (uint8_t)~C_PWM3_En;
            PORTA &= (uint8_t)~PIN_MASK_PA2_PWM3;
        }
    }

    /* Queue the chunk that follows the newly running chunk */
    encoded = determine_next_chunk();
    if (encoded == 0U)
    {
        /* Select the next stage before any standard-model ROM decoding */
        select_result = select_next_stage(&standard_stage_index);
        if (select_result == STAGE_SELECT_STANDARD)
        {
            waveform_model_load_stage(s_current_model_id, standard_stage_index);
            s_active_rem = g_stage_on_steps;
            s_inactive_rem = g_stage_off_steps;
            select_result = STAGE_SELECT_READY;
        }
        if (select_result == STAGE_SELECT_READY)
        {
            encoded = determine_next_chunk();
        }
    }

    if (encoded > 0U)
    {
        next_phase = (encoded & 0x80U) != 0U;
        next_chunk = encoded & 0x3FU;

        if ((next_phase != 0U) && (next_chunk == 2U))
        {
            if (s_inactive_rem > 0U)
            {
                prep_encoded = determine_next_chunk();
                prep_steps = prep_encoded & 0x3FU;
                reload = (uint16_t)(((uint16_t)prep_steps << 4) + ((uint16_t)prep_steps << 2) - 1U);
                tmrh_val = 0U;

                if ((reload & 0x0200U) != 0U)
                {
                    tmrh_val |= C_TMR2_Data_b9;
                }
                if ((reload & 0x0100U) != 0U)
                {
                    tmrh_val |= C_TMR2_Data_b8;
                }

                s_prep_tmrh = tmrh_val;
                s_prep_tmr2 = (uint8_t)reload;
                s_prep_inactive_steps = prep_steps;
            }
            else
            {
                s_prep_inactive_steps = 0U;
            }

            s_queued_phase = 1U;
            s_has_queued_chunk = 1U;
            timer2_queue_interval(2U);
        }
        else
        {
            s_queued_phase = next_phase;
            s_has_queued_chunk = 1U;
            timer2_queue_interval(next_chunk);
        }
    }
    else
    {
        s_has_queued_chunk = 0U;
        s_prep_inactive_steps = 0U;
    }
}

/**
 * @brief Primary interrupt service routine.
 */
void isr(void) __interrupt(0)
{
    /* 1. Primary Timer2 underflow check (highest priority) */
    if (INTFbits.T2IF)
    {
        service_timer2_underflow();
    }

    /* 2. Service Timer1 coarse 10 ms tick */
    if (INTFbits.T1IF)
    {
        INTFbits.T1IF = 0;
        if (s_running != 0U)
        {
            if (s_entry_timer_10ms != 0U)
            {
                s_entry_timer_10ms--;
                if (s_entry_timer_10ms == 0U)
                {
                    s_entry_expired = 1U;
                }
            }
        }

        /* Hardware LVD: LVDOUT=0 when VDD is below the selected 3.6 V threshold.
         * LEDs are active-low: PA7 green remains on; PA5 red toggles every 250 ms. */
        if ((PCON1 & 0x40U) == 0U)
        {
            s_red_blink_ticks++;
            if (s_red_blink_ticks >= 25U)
            {
                s_red_blink_ticks = 0U;
                PORTA ^= PIN_MASK_PA5_RED_LED;
            }
        }
        else
        {
            s_red_blink_ticks = 0U;
            PORTA |= PIN_MASK_PA5_RED_LED;
        }
    }

    /* 3. Service Watchdog Timer */
    if (INTFbits.WDTIF)
    {
        INTF = (uint8_t)~C_INT_WDT;
    }

    /* 4. Final bounded Timer2 underflow check before ISR exit */
    if (INTFbits.T2IF)
    {
        service_timer2_underflow();
    }
}

/**
 * @brief Application entry point.
 */
void main(void)
{
    DISI();
    PCON = C_WDT_En | C_LVR_En;

    gpio_init();
    PORTA |= PIN_MASK_PA0_POWER_HOLD;

    legacy_peripherals_disable();
    pwm3_init();
    timer1_init();
    timer2_init();
    interrupt_init();

    s_running = 1U;
    s_entry_index = 0U;
    s_entry_expired = 0U;
    s_red_blink_ticks = 0U;
    load_playlist_entry(0U);

    ENI();

    while (1)
    {
        CLRWDT();

        /* Macro-scheduler atomic execution in main thread context */
        if (s_entry_expired != 0U)
        {
            DISI();
            if (s_entry_expired != 0U)
            {
                s_entry_expired = 0U;
                s_entry_index++;
                if (s_entry_index >= PLAYLIST_ITEM_COUNT)
                {
                    s_running = 0U;
                    pwm3_set_enabled(false);
                    T2CR1 = C_TMR2_Dis;
                    INTFbits.T2IF = 0;
                    s_prep_inactive_steps = 0U;
                }
                else
                {
                    load_playlist_entry(s_entry_index);
                }
            }
            ENI();
        }
    }
}
