/**
 * @file waveform_perfect_model_gemini.h
 * @brief High-efficiency waveform catalog interface for NY8B062F (zero pointer calls).
 */

#ifndef WAVEFORM_PERFECT_MODEL_GEMINI_H
#define WAVEFORM_PERFECT_MODEL_GEMINI_H

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief Standard canonical models using packed 3-bit symbol sequences.
 */
typedef enum
{
    MODEL_ID_P0 = 0,             /**< P0 preamble model (64 stages, P=4). */
    MODEL_ID_C1,                 /**< C1 canonical model (63 stages, P=4). */
    MODEL_ID_C3_PREFIX,          /**< C3 prefix model (49 stages, P=4). */
    MODEL_ID_C3_BODY,            /**< C3 body model (60 stages, P=2). */
    MODEL_ID_C4,                 /**< C4 canonical model (63 stages, P=2). */
    MODEL_ID_C5,                 /**< C5 canonical model (43 stages, P=3). */
    MODEL_ID_C6,                 /**< C6 canonical model (63 stages, P=2). */
    MODEL_ID_C7,                 /**< C7 canonical model (63 stages, P=2). */
    MODEL_ID_C8_A,               /**< C8-A canonical model (77 stages, P=4). */
    MODEL_ID_C9_PREAMBLE_INIT,   /**< C9 preamble initialization model (52 stages, P=4). */
    MODEL_ID_C9_PREAMBLE,        /**< C9 preamble model (41 stages, P=3). */
    MODEL_ID_C9_MAIN_INIT,       /**< C9 main initialization model (69 stages, P=4, L=192). */
    MODEL_ID_C9_MAIN,            /**< C9 main model (42 stages, P=16 with exceptions). */
    MODEL_ID_C11,                /**< C11 canonical model (55 stages, P=4). */
    MODEL_ID_STANDARD_COUNT      /**< Total count of standard packed models. */
} model_id_t;

/* Global stage output variables in static SRAM (eliminates generic pointer getters/setters) */
extern uint16_t g_stage_on_steps;
extern uint16_t g_stage_off_steps;

/**
 * @brief Retrieve total canonical stage count for a standard model.
 * @param[in] model_id Identifier of the standard packed model.
 * @return Stage count, or 0 if identifier is invalid.
 */
uint8_t waveform_model_get_stage_count(uint8_t model_id);

/**
 * @brief Load on/off timing for one stage of a standard model into g_stage_on_steps and g_stage_off_steps.
 * @param[in] model_id Standard model identifier.
 * @param[in] stage_index Zero-based stage index.
 */
void waveform_model_load_stage(uint8_t model_id, uint8_t stage_index);

/**
 * @brief Load on/off timing for one stage of the canonical C10 sequence (no leading 1-slot prefix).
 * @param[in] phase C10 subphase: 0 = Body (9 rounds of 26 slots), 1 = Tail (14 slots), 2 = Special (7 slots).
 * @param[in] stage Stage index within the subphase (0..25 for Body, 0..13 for Tail, 0..6 for Special).
 * @return true if valid stage timing was loaded into g_stage_on_steps and g_stage_off_steps; false if phase >= 3.
 */
bool waveform_model_load_c10_stage(uint8_t phase, uint8_t stage);

#endif /* WAVEFORM_PERFECT_MODEL_GEMINI_H */
