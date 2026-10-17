/**
 * @file waveform_perfect_model_gemini.c
 * @brief Zero-pointer 2-bit compact waveform catalog implementation for NY8B062F.
 */

#include "waveform_perfect_model_gemini.h"

/* Local model IDs appended after the public packed-model enum without changing the header ABI. */
#define MODEL_ID_MOVANO_LOCAL ((uint8_t)MODEL_ID_STANDARD_COUNT)
#define MODEL_ID_VIBE_LOCAL   ((uint8_t)(MODEL_ID_STANDARD_COUNT + 1U))

/* Global stage output variables */
uint16_t g_stage_on_steps;
uint16_t g_stage_off_steps;


/* Movano stages 49..86: ideal 16-step Manchester run classes.
 * 0=P16/S32, 1=P16/S48, 2=P32/S48, 3=P32/S64.
 * The packed stream preserves the Session 42 raw payload C2 BC E7 85 D8 7A. */
static const uint8_t __code c_movano_payload[] =
{
    0x04U, 0xBCU, 0x10U, 0x12U, 0x42U, 0xC0U, 0x92U, 0x01U,
    0x42U, 0x03U
};

/* P0: A*19 D A C*2 A*2 B*3 C*2 A*7 B A*10 B C B A*5 B A B*3 A*2 L (64 stages, P=4, L=304) */
static const uint8_t __code c_shape_p0[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x54U, 0x0AU,
    0x00U, 0x04U, 0x00U, 0x00U, 0x19U, 0x00U, 0x51U, 0x01U
};

/* C1 and C7 shared shape: A*19 D A C*2 A B A*3 B*2 C A*2 C A B A B A B A A B A*3 C B A B*3 A*3 B A*2 B C A D E */
static const uint8_t __code c_shape_c1_c7[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x01U, 0x25U,
    0x48U, 0x44U, 0x10U, 0x60U, 0x54U, 0x40U, 0x90U, 0x0CU
};

/* C3-prefix: A*19 D A C*2 A B C A C B*2 C A C B A*11 B*2 A L (49 stages, P=4, L=240) */
static const uint8_t __code c_shape_c3_prefix[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x89U, 0x25U,
    0x06U, 0x00U, 0x00U, 0x14U, 0x00U
};

/* C3-body: A*19 D A C*2 A B*2 A B A*2 C*2 A*3 B A B*3 A*3 B A*2 B C*3 A B A*2 B A*3 C L (60 stages, P=2, L=256) */
static const uint8_t __code c_shape_c3_body[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x45U, 0xA0U,
    0x40U, 0x54U, 0x40U, 0x90U, 0x4AU, 0x10U, 0x20U
};

/* C4: A*19 D A C*2 A B A B A*2 B C*2 A*3 B A*2 B*3 A*3 B A B A B*2 A C A B A*2 B A*2 B*2 D E (63 stages, P=2) */
static const uint8_t __code c_shape_c4[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x11U, 0xA4U,
    0x40U, 0x50U, 0x01U, 0x11U, 0x85U, 0x04U, 0x41U, 0x0DU
};

/* C5: A*19 D A C*2 A B C A C B*2 C A C*5 A*2 C*3 L (43 stages, P=3, L=3300) */
static const uint8_t __code c_shape_c5[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x89U, 0x25U,
    0xAAU, 0x82U, 0x0AU
};

/* C6: A*19 D A C*2 A B A*3 C*2 B A*2 B A B A B A B A*2 B A*3 C B A B*3 A*3 B A*2 B C A D E (63 stages, P=2) */
static const uint8_t __code c_shape_c6[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x01U, 0x1AU,
    0x44U, 0x44U, 0x10U, 0x60U, 0x54U, 0x40U, 0x90U, 0x0CU
};

/* C8-A: A*19 D A C*2 A*4 B A*3 B A*2 B A*4 C*3 B A B*2 A B*2 A*16 B C*3 A B A B*3 L E (77 stages, P=4, L=288) */
static const uint8_t __code c_shape_c8_a[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x28U, 0x40U, 0x40U,
    0x10U, 0x80U, 0x1AU, 0x45U, 0x01U, 0x00U, 0x00U, 0x00U,
    0xA4U, 0x12U, 0x15U, 0x00U
};

/* C9-Preamble-Init: A*16 D A C*2 B C A*2 C A*2 C A B A B A*3 C A*2 C A*5 B A*3 B C B C (52 stages, P=4) */
static const uint8_t __code c_shape_c9_preamble_init[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xA3U, 0x09U, 0x82U, 0x44U,
    0x80U, 0x20U, 0x00U, 0x01U, 0x99U
};

/* C9-Preamble: A*7 D A C*2 A*13 B C A C A B A*3 B*3 A*3 L E (41 stages, P=3, L=3760) */
static const uint8_t __code c_shape_c9_preamble[] =
{
    0x00U, 0xC0U, 0x28U, 0x00U, 0x00U, 0x00U, 0x89U, 0x04U,
    0x54U, 0x00U, 0x00U
};

/* C9-Main-Init: A*24 D A C*2 A*2 B*3 C*2 A*7 B A*10 B C B A*4 B A*3 B*2 A*2 L (69 stages, P=4, L=192) */
static const uint8_t __code c_shape_c9_main_init[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0xA3U, 0x50U,
    0x29U, 0x00U, 0x10U, 0x00U, 0x00U, 0x64U, 0x00U, 0x01U,
    0x05U, 0x00U
};

/* C9-Main: A*7 D A C*2 A*13 B C A*8 B A*6 L (42 stages, default P=16, L=3904) */
static const uint8_t __code c_shape_c9_main[] =
{
    0x00U, 0xC0U, 0x28U, 0x00U, 0x00U, 0x00U, 0x09U, 0x00U,
    0x10U, 0x00U, 0x00U
};

/* C11: A*19 D A C*2 B C*3 B*2 C*4 B A B*3 C A*2 C A*3 B*2 C*3 A C A*3 (55 stages, P=4) */
static const uint8_t __code c_shape_c11[] =
{
    0x00U, 0x00U, 0x00U, 0x00U, 0xC0U, 0x68U, 0x6AU, 0xA9U,
    0x46U, 0x25U, 0x08U, 0x94U, 0x8AU, 0x00U
};

/**
 * @brief Load on/off timing for one stage of a standard model into global variables.
 * @note Place switch mappings directly inside this function without callable helpers.
 */
void waveform_model_load_stage(uint8_t model_id, uint8_t stage_index)
{
    const uint8_t __code *shape;
    uint16_t long_s;
    uint8_t pulse;
    uint8_t bit_offset;
    uint8_t byte_idx;
    uint8_t shift;
    uint8_t code;
    uint16_t total_s;

    /* Movano: compact branch structure; no nested helper calls. */
    if (model_id == MODEL_ID_MOVANO_LOCAL)
    {
        if (stage_index < 45U)
        {
            g_stage_on_steps = 16U;
            g_stage_off_steps = 16U;      /* S32P16: one ideal Manchester bit cell */
            return;
        }

        if (stage_index == 45U)
        {
            g_stage_on_steps = 48U;
            g_stage_off_steps = 48U;      /* S96P48 */
            return;
        }

        if (stage_index < 49U)
        {
            if (stage_index == 46U)
            {
                g_stage_on_steps = 16U;
                g_stage_off_steps = 16U;  /* S32P16 */
            }
            else
            {
                g_stage_on_steps = 32U;
                g_stage_off_steps = 32U;  /* S64P32 */
            }
            return;
        }

        if (stage_index == 87U)
        {
            g_stage_on_steps = 16U;
            g_stage_off_steps = 496U;     /* S512P16: exact 4.096 ms stage */
            return;
        }

        bit_offset = (uint8_t)(stage_index - 49U);
        byte_idx = (uint8_t)(bit_offset >> 2);
        shift = (uint8_t)((bit_offset & 0x03U) << 1);
        code = (uint8_t)((c_movano_payload[byte_idx] >> shift) & 0x03U);

        g_stage_on_steps = ((code & 0x02U) != 0U) ? 32U : 16U;
        g_stage_off_steps = ((code & 0x01U) != 0U) ? 32U : 16U;
        return;
    }

    /* Pontiac Vibe: stages 2/3/5 are defaults; exceptions override them. */
    if (model_id == MODEL_ID_VIBE_LOCAL)
    {
        g_stage_on_steps = 1250U;
        g_stage_off_steps = 1250U;

        if (stage_index == 0U)
        {
            g_stage_on_steps = 25000U;
            g_stage_off_steps = 2500U;
        }
        else if (stage_index == 1U)
        {
            g_stage_on_steps = 2500U;
        }
        else if (stage_index == 4U)
        {
            g_stage_off_steps = 2500U;
        }
        else if (stage_index == 6U)
        {
            g_stage_on_steps = 2500U;
            g_stage_off_steps = 37500U;
        }
        return;
    }

    /* Standard models: map directly in this leaf; bit_offset temporarily holds last stage index. */
    switch (model_id)
    {
        case (uint8_t)MODEL_ID_P0:
            shape = c_shape_p0;
            long_s = 304U;
            pulse = 4U;
            bit_offset = 63U;
            break;
        case (uint8_t)MODEL_ID_C1:
            shape = c_shape_c1_c7;
            long_s = 128U;                 /* Final E */
            pulse = 4U;
            bit_offset = 62U;
            break;
        case (uint8_t)MODEL_ID_C3_PREFIX:
            shape = c_shape_c3_prefix;
            long_s = 240U;
            pulse = 4U;
            bit_offset = 48U;
            break;
        case (uint8_t)MODEL_ID_C3_BODY:
            shape = c_shape_c3_body;
            long_s = 256U;
            pulse = 2U;
            bit_offset = 59U;
            break;
        case (uint8_t)MODEL_ID_C4:
            shape = c_shape_c4;
            long_s = 128U;                 /* Final E */
            pulse = 2U;
            bit_offset = 62U;
            break;
        case (uint8_t)MODEL_ID_C5:
            shape = c_shape_c5;
            long_s = 3300U;
            pulse = 3U;
            bit_offset = 42U;
            break;
        case (uint8_t)MODEL_ID_C6:
            shape = c_shape_c6;
            long_s = 128U;                 /* Final E */
            pulse = 2U;
            bit_offset = 62U;
            break;
        case (uint8_t)MODEL_ID_C7:
            shape = c_shape_c1_c7;
            long_s = 128U;                 /* Final E */
            pulse = 2U;
            bit_offset = 62U;
            break;
        case (uint8_t)MODEL_ID_C8_A:
            shape = c_shape_c8_a;
            long_s = 288U;                 /* Penultimate L; final E handled below */
            pulse = 4U;
            bit_offset = 76U;
            break;
        case (uint8_t)MODEL_ID_C9_PREAMBLE_INIT:
            shape = c_shape_c9_preamble_init;
            long_s = 0U;
            pulse = 4U;
            bit_offset = 51U;
            break;
        case (uint8_t)MODEL_ID_C9_PREAMBLE:
            shape = c_shape_c9_preamble;
            long_s = 3760U;                /* Penultimate L; final E handled below */
            pulse = 3U;
            bit_offset = 40U;
            break;
        case (uint8_t)MODEL_ID_C9_MAIN_INIT:
            shape = c_shape_c9_main_init;
            long_s = 192U;
            pulse = 4U;
            bit_offset = 68U;
            break;
        case (uint8_t)MODEL_ID_C9_MAIN:
            shape = c_shape_c9_main;
            long_s = 3904U;
            pulse = 16U;
            bit_offset = 41U;
            break;
        case (uint8_t)MODEL_ID_C11:
            shape = c_shape_c11;
            long_s = 0U;
            pulse = 4U;
            bit_offset = 54U;
            break;
        default:
            g_stage_on_steps = 0U;
            g_stage_off_steps = 0U;
            return;
    }

    /* Tail symbols E/L are implicit so the main shape stream needs only A/B/C/D (2 bits). */
    if (((model_id == (uint8_t)MODEL_ID_C8_A) && (stage_index == 75U)) ||
        ((model_id == (uint8_t)MODEL_ID_C9_PREAMBLE) && (stage_index == 39U)))
    {
        total_s = long_s;
    }
    else if (((model_id == (uint8_t)MODEL_ID_C8_A) && (stage_index == 76U)) ||
             ((model_id == (uint8_t)MODEL_ID_C9_PREAMBLE) && (stage_index == 40U)))
    {
        total_s = 128U;
    }
    else if ((long_s != 0U) && (stage_index == bit_offset))
    {
        total_s = long_s;
    }
    else
    {
        /* Four A/B/C/D symbols per byte; no cross-byte extraction and no x3 index math. */
        byte_idx = (uint8_t)(stage_index >> 2);
        shift = (uint8_t)((stage_index & 0x03U) << 1);
        code = (uint8_t)((shape[byte_idx] >> shift) & 0x03U);

        if (code == 3U)
        {
            total_s = 96U;                 /* D */
        }
        else
        {
            total_s = (uint16_t)(((uint16_t)code << 4) + 32U); /* A/B/C */
        }
    }

    /* Handle C9-Main explicit pulse exceptions. */
    if (model_id == (uint8_t)MODEL_ID_C9_MAIN)
    {
        if (stage_index == 7U)
        {
            pulse = 48U;                   /* D48 */
        }
        else if ((stage_index == 9U) || (stage_index == 10U) ||
                 (stage_index == 25U) || (stage_index == 34U))
        {
            pulse = 32U;                   /* C32, B32 */
        }
    }

    g_stage_on_steps = pulse;
    g_stage_off_steps = (uint16_t)(total_s - pulse);
}

/**
 * @brief Load on/off timing for one stage of the canonical C10 sequence (no leading 1-slot prefix).
 */
bool waveform_model_load_c10_stage(uint8_t phase, uint8_t stage)
{
    if (phase == 0U)
    {
        /* Canonical 26-slot Body (no leading 1-slot prefix) */
        if (stage < 15U)
        {
            /* Slots 0 through 14: S1372P125 */
            g_stage_on_steps = 125U;
            g_stage_off_steps = 1247U;
            return true;
        }

        switch (stage)
        {
            case 15U: g_stage_on_steps = 561U; g_stage_off_steps = 125U;  return true; /* Slot 16: S686P561 */
            case 16U: g_stage_on_steps = 125U; g_stage_off_steps = 125U;  return true; /* Slot 17: S250P125 */
            case 17U: g_stage_on_steps = 88U;  g_stage_off_steps = 124U;  return true; /* Slot 18: S212P88  */
            case 18U: g_stage_on_steps = 88U;  g_stage_off_steps = 124U;  return true; /* Slot 19: S212P88  */
            case 19U: g_stage_on_steps = 213U; g_stage_off_steps = 124U;  return true; /* Slot 20: S337P213 */
            case 20U: g_stage_on_steps = 88U;  g_stage_off_steps = 125U;  return true; /* Slot 21: S213P88  */
            case 21U: g_stage_on_steps = 213U; g_stage_off_steps = 124U;  return true; /* Slot 22: S337P213 */
            case 22U: g_stage_on_steps = 213U; g_stage_off_steps = 124U;  return true; /* Slot 23: S337P213 */
            case 23U: g_stage_on_steps = 88U;  g_stage_off_steps = 124U;  return true; /* Slot 24: S212P88  */
            case 24U: g_stage_on_steps = 213U; g_stage_off_steps = 375U;  return true; /* Slot 25: S588P213 */
            case 25U: g_stage_on_steps = 63U;  g_stage_off_steps = 1496U; return true; /* Slot 26: S1559P63 */
            default:  return false;
        }
    }

    if (phase == 1U)
    {
        /* C10 Tail: 14 slots (13x S1372P125 + 1x S25420P125) */
        if (stage < 13U)
        {
            g_stage_on_steps = 125U;
            g_stage_off_steps = 1247U;
            return true;
        }
        else if (stage == 13U)
        {
            g_stage_on_steps = 125U;
            g_stage_off_steps = 25295U;
            return true;
        }
        return false;
    }

    if (phase == 2U)
    {
        /* C10 Special Events: 7 slots */
        switch (stage)
        {
            case 0U: g_stage_on_steps = 50000U; g_stage_off_steps = 5000U; return true; /* S55000P50000 */
            case 1U: g_stage_on_steps = 5000U;  g_stage_off_steps = 2500U; return true; /* S7500P5000   */
            case 2U: g_stage_on_steps = 2500U;  g_stage_off_steps = 2500U; return true; /* S5000P2500   */
            case 3U: g_stage_on_steps = 2500U;  g_stage_off_steps = 2500U; return true; /* S5000P2500   */
            case 4U: g_stage_on_steps = 2500U;  g_stage_off_steps = 5000U; return true; /* S7500P2500   */
            case 5U: g_stage_on_steps = 2500U;  g_stage_off_steps = 2500U; return true; /* S5000P2500   */
            case 6U: g_stage_on_steps = 5000U;  g_stage_off_steps = 0U;    return true; /* S5000P5000   */
            default: return false;
        }
    }

    return false;
}
