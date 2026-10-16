;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #0 (MSVC)
;--------------------------------------------------------
; NY8A port
;--------------------------------------------------------
	.file	"waveform_perfect_model_gemini.c"
	list	p=NY8B062F,c=on
	#include "ny8b062f.inc"
	.debuginfo language C89
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_waveform_model_get_stage_count
	extern	__gptrget1

	extern PSAVE
	extern SSAVE
	extern WSAVE
	extern STK12
	extern ___STK12
	extern STK11
	extern ___STK11
	extern STK10
	extern ___STK10
	extern STK09
	extern ___STK09
	extern STK08
	extern ___STK08
	extern STK07
	extern ___STK07
	extern STK06
	extern ___STK06
	extern STK05
	extern ___STK05
	extern STK04
	extern ___STK04
	extern STK03
	extern ___STK03
	extern STK02
	extern ___STK02
	extern STK01
	extern ___STK01
	extern STK00
	extern ___STK00
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	extern	_g_stage_off_steps
	extern	_g_stage_on_steps
	extern	_waveform_model_load_stage
	extern	_waveform_model_load_c10_stage

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
.segment "uninit"
_g_stage_on_steps:
	.res 2
	.debuginfo complex-type (symbol "_g_stage_on_steps" 2 global "waveform_perfect_model_gemini.c" 13 (basetype 2 unsigned))

.segment "uninit"
_g_stage_off_steps:
	.res 2
	.debuginfo complex-type (symbol "_g_stage_off_steps" 2 global "waveform_perfect_model_gemini.c" 14 (basetype 2 unsigned))

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
.segment "uninit"
r0x1007:
	.res	1
.segment "uninit"
r0x1008:
	.res	1
.segment "uninit"
r0x1009:
	.res	1
.segment "uninit"
r0x100A:
	.res	1
.segment "uninit"
r0x100B:
	.res	1
.segment "uninit"
r0x100C:
	.res	1
.segment "uninit"
r0x100D:
	.res	1
.segment "uninit"
r0x100E:
	.res	1
.segment "uninit"
r0x100F:
	.res	1
.segment "uninit"
r0x1010:
	.res	1
.segment "uninit"
r0x1011:
	.res	1
.segment "uninit"
r0x1012:
	.res	1
.segment "uninit"
r0x1004:
	.res	1
.segment "uninit"
r0x1005:
	.res	1
.segment "uninit"
r0x1006:
	.res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

.segment "code"
_c_movano_payload:
	retia 0x04	; 4
	retia 0xbc	; 188
	retia 0x10	; 16
	retia 0x12	; 18
	retia 0x40	; 64
	retia 0xc0	; 192
	retia 0x92	; 146
	retia 0x01	; 1
	retia 0x42	; 66	'B'
	retia 0x03	; 3

.segment "code"
_c_shape_p0:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x54	; 84	'T'
	retia 0x0a	; 10
	retia 0x00	; 0
	retia 0x04	; 4
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x19	; 25
	retia 0x00	; 0
	retia 0x51	; 81	'Q'
	retia 0x01	; 1

.segment "code"
_c_shape_c1_c7:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x01	; 1
	retia 0x25	; 37
	retia 0x48	; 72	'H'
	retia 0x44	; 68	'D'
	retia 0x10	; 16
	retia 0x60	; 96
	retia 0x54	; 84	'T'
	retia 0x40	; 64
	retia 0x90	; 144
	retia 0x0c	; 12

.segment "code"
_c_shape_c3_prefix:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x89	; 137
	retia 0x25	; 37
	retia 0x06	; 6
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x14	; 20
	retia 0x00	; 0

.segment "code"
_c_shape_c3_body:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x45	; 69	'E'
	retia 0xa0	; 160
	retia 0x40	; 64
	retia 0x54	; 84	'T'
	retia 0x40	; 64
	retia 0x90	; 144
	retia 0x4a	; 74	'J'
	retia 0x10	; 16
	retia 0x20	; 32

.segment "code"
_c_shape_c4:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x11	; 17
	retia 0xa4	; 164
	retia 0x40	; 64
	retia 0x50	; 80	'P'
	retia 0x01	; 1
	retia 0x11	; 17
	retia 0x85	; 133
	retia 0x04	; 4
	retia 0x41	; 65	'A'
	retia 0x0d	; 13

.segment "code"
_c_shape_c5:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x89	; 137
	retia 0x25	; 37
	retia 0xaa	; 170
	retia 0x82	; 130
	retia 0x0a	; 10

.segment "code"
_c_shape_c6:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x01	; 1
	retia 0x1a	; 26
	retia 0x44	; 68	'D'
	retia 0x44	; 68	'D'
	retia 0x10	; 16
	retia 0x60	; 96
	retia 0x54	; 84	'T'
	retia 0x40	; 64
	retia 0x90	; 144
	retia 0x0c	; 12

.segment "code"
_c_shape_c8_a:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x40	; 64
	retia 0x40	; 64
	retia 0x10	; 16
	retia 0x80	; 128
	retia 0x1a	; 26
	retia 0x45	; 69	'E'
	retia 0x01	; 1
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xa4	; 164
	retia 0x12	; 18
	retia 0x15	; 21
	retia 0x00	; 0

.segment "code"
_c_shape_c9_preamble_init:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xa3	; 163
	retia 0x09	; 9
	retia 0x82	; 130
	retia 0x44	; 68	'D'
	retia 0x80	; 128
	retia 0x20	; 32
	retia 0x00	; 0
	retia 0x01	; 1
	retia 0x99	; 153

.segment "code"
_c_shape_c9_preamble:
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x89	; 137
	retia 0x04	; 4
	retia 0x54	; 84	'T'
	retia 0x00	; 0
	retia 0x00	; 0

.segment "code"
_c_shape_c9_main_init:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xa3	; 163
	retia 0x50	; 80	'P'
	retia 0x29	; 41
	retia 0x00	; 0
	retia 0x10	; 16
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x64	; 100	'd'
	retia 0x00	; 0
	retia 0x01	; 1
	retia 0x05	; 5
	retia 0x00	; 0

.segment "code"
_c_shape_c9_main:
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x28	; 40
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x09	; 9
	retia 0x00	; 0
	retia 0x10	; 16
	retia 0x00	; 0
	retia 0x00	; 0

.segment "code"
_c_shape_c11:
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0x00	; 0
	retia 0xc0	; 192
	retia 0x68	; 104	'h'
	retia 0x6a	; 106	'j'
	retia 0xa9	; 169
	retia 0x46	; 70	'F'
	retia 0x25	; 37
	retia 0x08	; 8
	retia 0x94	; 148
	retia 0x8a	; 138
	retia 0x00	; 0
;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; code
;--------------------------------------------------------
; code_waveform_perfect_model_gemini	code
;***
;  pBlock Stats: dbName = C
;***
;has an exit
;4 compiler assigned registers:
;   r0x1004
;   STK00
;   r0x1005
;   r0x1006
;; Starting pCode block
.segment "code"; module=waveform_perfect_model_gemini, function=_waveform_model_load_c10_stage
	.debuginfo subprogram _waveform_model_load_c10_stage
;local variable name mapping:
	.debuginfo complex-type (local-sym "_phase" 1 "waveform_perfect_model_gemini.c" 360 (basetype 1 unsigned) split "r0x1004")
	.debuginfo complex-type (local-sym "_stage" 1 "waveform_perfect_model_gemini.c" 360 (basetype 1 unsigned) split "r0x1005")
_waveform_model_load_c10_stage:
; 2 exit points
	.line	360, "waveform_perfect_model_gemini.c"; 	bool waveform_model_load_c10_stage(uint8_t phase, uint8_t stage)
	BANKSEL	r0x1004
	MOVAR	r0x1004
	MOVR	STK00,W
	BANKSEL	r0x1005
	MOVAR	r0x1005
	.line	362, "waveform_perfect_model_gemini.c"; 	if (phase == 0U)
	BANKSEL	r0x1004
	MOVR	r0x1004,W
	BTRSS	STATUS,2
	MGOTO	_02251_DS_
;;unsigned compare: left < lit(0xF=15), size=1
	.line	365, "waveform_perfect_model_gemini.c"; 	if (stage < 15U)
	MOVIA	0x0f
	BANKSEL	r0x1005
	SUBAR	r0x1005,W
	BANKSEL	r0x1006
	CLRR	r0x1006
	BTRSS	STATUS,0
	BSR	r0x1006,0
	MOVR	r0x1006,W
	BTRSC	STATUS,2
	MGOTO	_02236_DS_
	.line	368, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 125U;
	MOVIA	0x7d
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	369, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 1247U;
	MOVIA	0xdf
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x04
	MOVAR	(_g_stage_off_steps + 1)
	.line	370, "waveform_perfect_model_gemini.c"; 	return true;
	MOVIA	0x01
	MGOTO	_02270_DS_
_02236_DS_:
	.line	373, "waveform_perfect_model_gemini.c"; 	switch (stage)
	BANKSEL	r0x1006
	MOVR	r0x1006,W
	BTRSS	STATUS,2
	MGOTO	_02248_DS_
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x1A=26), size=1
	MOVIA	0x1a
	BANKSEL	r0x1005
	SUBAR	r0x1005,W
	BTRSC	STATUS,0
	MGOTO	_02248_DS_
	MOVIA	0xf1
	ADDAR	r0x1005,W
	BANKSEL	r0x1006
	MOVAR	r0x1006
	MOVIA	((_02308_DS_ >> 8) & 0xff)
	MOVAR	PCHBUF
	MOVR	r0x1006,W
	ADDIA	_02308_DS_
	BTRSC	STATUS,0
	INCR	PCHBUF,F
	MOVAR	PCL
_02308_DS_:
	MGOTO	_02237_DS_
	MGOTO	_02238_DS_
	MGOTO	_02239_DS_
	MGOTO	_02240_DS_
	MGOTO	_02241_DS_
	MGOTO	_02242_DS_
	MGOTO	_02243_DS_
	MGOTO	_02244_DS_
	MGOTO	_02245_DS_
	MGOTO	_02246_DS_
	MGOTO	_02247_DS_
_02237_DS_:
	.line	375, "waveform_perfect_model_gemini.c"; 	case 15U: g_stage_on_steps = 561U; g_stage_off_steps = 125U;  return true; /* Slot 16: S686P561 */
	MOVIA	0x31
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x02
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0x7d
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02238_DS_:
	.line	376, "waveform_perfect_model_gemini.c"; 	case 16U: g_stage_on_steps = 125U; g_stage_off_steps = 125U;  return true; /* Slot 17: S250P125 */
	MOVIA	0x7d
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7d
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02239_DS_:
	.line	377, "waveform_perfect_model_gemini.c"; 	case 17U: g_stage_on_steps = 88U;  g_stage_off_steps = 124U;  return true; /* Slot 18: S212P88  */
	MOVIA	0x58
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02240_DS_:
	.line	378, "waveform_perfect_model_gemini.c"; 	case 18U: g_stage_on_steps = 88U;  g_stage_off_steps = 124U;  return true; /* Slot 19: S212P88  */
	MOVIA	0x58
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02241_DS_:
	.line	379, "waveform_perfect_model_gemini.c"; 	case 19U: g_stage_on_steps = 213U; g_stage_off_steps = 124U;  return true; /* Slot 20: S337P213 */
	MOVIA	0xd5
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02242_DS_:
	.line	380, "waveform_perfect_model_gemini.c"; 	case 20U: g_stage_on_steps = 88U;  g_stage_off_steps = 125U;  return true; /* Slot 21: S213P88  */
	MOVIA	0x58
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7d
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02243_DS_:
	.line	381, "waveform_perfect_model_gemini.c"; 	case 21U: g_stage_on_steps = 213U; g_stage_off_steps = 124U;  return true; /* Slot 22: S337P213 */
	MOVIA	0xd5
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02244_DS_:
	.line	382, "waveform_perfect_model_gemini.c"; 	case 22U: g_stage_on_steps = 213U; g_stage_off_steps = 124U;  return true; /* Slot 23: S337P213 */
	MOVIA	0xd5
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02245_DS_:
	.line	383, "waveform_perfect_model_gemini.c"; 	case 23U: g_stage_on_steps = 88U;  g_stage_off_steps = 124U;  return true; /* Slot 24: S212P88  */
	MOVIA	0x58
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02246_DS_:
	.line	384, "waveform_perfect_model_gemini.c"; 	case 24U: g_stage_on_steps = 213U; g_stage_off_steps = 375U;  return true; /* Slot 25: S588P213 */
	MOVIA	0xd5
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0x77
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x01
	MOVAR	(_g_stage_off_steps + 1)
	MGOTO	_02270_DS_
_02247_DS_:
	.line	385, "waveform_perfect_model_gemini.c"; 	case 25U: g_stage_on_steps = 63U;  g_stage_off_steps = 1496U; return true; /* Slot 26: S1559P63 */
	MOVIA	0x3f
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	MOVIA	0xd8
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x05
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02248_DS_:
	.line	386, "waveform_perfect_model_gemini.c"; 	default:  return false;
	MOVIA	0x00
	MGOTO	_02270_DS_
_02251_DS_:
	.line	390, "waveform_perfect_model_gemini.c"; 	if (phase == 1U)
	BANKSEL	r0x1004
	MOVR	r0x1004,W
	XORIA	0x01
	BTRSS	STATUS,2
	MGOTO	_02258_DS_
;;unsigned compare: left < lit(0xD=13), size=1
	.line	393, "waveform_perfect_model_gemini.c"; 	if (stage < 13U)
	MOVIA	0x0d
	BANKSEL	r0x1005
	SUBAR	r0x1005,W
	BTRSC	STATUS,0
	MGOTO	_02255_DS_
	.line	395, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 125U;
	MOVIA	0x7d
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	396, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 1247U;
	MOVIA	0xdf
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x04
	MOVAR	(_g_stage_off_steps + 1)
	.line	397, "waveform_perfect_model_gemini.c"; 	return true;
	MOVIA	0x01
	MGOTO	_02270_DS_
_02255_DS_:
	.line	399, "waveform_perfect_model_gemini.c"; 	else if (stage == 13U)
	BANKSEL	r0x1005
	MOVR	r0x1005,W
	XORIA	0x0d
	BTRSS	STATUS,2
	MGOTO	_02256_DS_
	.line	401, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 125U;
	MOVIA	0x7d
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	402, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 25295U;
	MOVIA	0xcf
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x62
	MOVAR	(_g_stage_off_steps + 1)
	.line	403, "waveform_perfect_model_gemini.c"; 	return true;
	MOVIA	0x01
	MGOTO	_02270_DS_
_02256_DS_:
	.line	405, "waveform_perfect_model_gemini.c"; 	return false;
	MOVIA	0x00
	MGOTO	_02270_DS_
_02258_DS_:
	.line	408, "waveform_perfect_model_gemini.c"; 	if (phase == 2U)
	BANKSEL	r0x1004
	MOVR	r0x1004,W
	XORIA	0x02
	BTRSS	STATUS,2
	MGOTO	_02269_DS_
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x7=7), size=1
	.line	411, "waveform_perfect_model_gemini.c"; 	switch (stage)
	MOVIA	0x07
	BANKSEL	r0x1005
	SUBAR	r0x1005,W
	BTRSC	STATUS,0
	MGOTO	_02266_DS_
	MOVIA	((_02309_DS_ >> 8) & 0xff)
	MOVAR	PCHBUF
	MOVR	r0x1005,W
	ADDIA	_02309_DS_
	BTRSC	STATUS,0
	INCR	PCHBUF,F
	MOVAR	PCL
_02309_DS_:
	MGOTO	_02259_DS_
	MGOTO	_02260_DS_
	MGOTO	_02261_DS_
	MGOTO	_02262_DS_
	MGOTO	_02263_DS_
	MGOTO	_02264_DS_
	MGOTO	_02265_DS_
_02259_DS_:
	.line	413, "waveform_perfect_model_gemini.c"; 	case 0U: g_stage_on_steps = 50000U; g_stage_off_steps = 5000U; return true; /* S55000P50000 */
	MOVIA	0x50
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0xc3
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0x88
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x13
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02260_DS_:
	.line	414, "waveform_perfect_model_gemini.c"; 	case 1U: g_stage_on_steps = 5000U;  g_stage_off_steps = 2500U; return true; /* S7500P5000   */
	MOVIA	0x88
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x13
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0xc4
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x09
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02261_DS_:
	.line	415, "waveform_perfect_model_gemini.c"; 	case 2U: g_stage_on_steps = 2500U;  g_stage_off_steps = 2500U; return true; /* S5000P2500   */
	MOVIA	0xc4
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x09
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0xc4
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x09
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02262_DS_:
	.line	416, "waveform_perfect_model_gemini.c"; 	case 3U: g_stage_on_steps = 2500U;  g_stage_off_steps = 2500U; return true; /* S5000P2500   */
	MOVIA	0xc4
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x09
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0xc4
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x09
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02263_DS_:
	.line	417, "waveform_perfect_model_gemini.c"; 	case 4U: g_stage_on_steps = 2500U;  g_stage_off_steps = 5000U; return true; /* S7500P2500   */
	MOVIA	0xc4
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x09
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0x88
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x13
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02264_DS_:
	.line	418, "waveform_perfect_model_gemini.c"; 	case 5U: g_stage_on_steps = 2500U;  g_stage_off_steps = 2500U; return true; /* S5000P2500   */
	MOVIA	0xc4
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x09
	MOVAR	(_g_stage_on_steps + 1)
	MOVIA	0xc4
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x09
	MOVAR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02265_DS_:
	.line	419, "waveform_perfect_model_gemini.c"; 	case 6U: g_stage_on_steps = 5000U;  g_stage_off_steps = 0U;    return true; /* S5000P5000   */
	MOVIA	0x88
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x13
	MOVAR	(_g_stage_on_steps + 1)
	BANKSEL	_g_stage_off_steps
	CLRR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MOVIA	0x01
	MGOTO	_02270_DS_
_02266_DS_:
	.line	420, "waveform_perfect_model_gemini.c"; 	default: return false;
	MOVIA	0x00
	MGOTO	_02270_DS_
_02269_DS_:
	.line	424, "waveform_perfect_model_gemini.c"; 	return false;
	MOVIA	0x00
_02270_DS_:
	.line	425, "waveform_perfect_model_gemini.c"; 	}
	RETURN	
; exit point of _waveform_model_load_c10_stage

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrget1
;   __gptrget1
;   __gptrget1
;   __gptrget1
;14 compiler assigned registers:
;   r0x1007
;   STK00
;   r0x1008
;   r0x1009
;   r0x100A
;   r0x100B
;   STK01
;   r0x100C
;   r0x100D
;   r0x100E
;   r0x100F
;   r0x1010
;   r0x1011
;   r0x1012
;; Starting pCode block
.segment "code"; module=waveform_perfect_model_gemini, function=_waveform_model_load_stage
	.debuginfo subprogram _waveform_model_load_stage
;local variable name mapping:
	.debuginfo complex-type (local-sym "_model_id" 1 "waveform_perfect_model_gemini.c" 122 (basetype 1 unsigned) split "r0x1007")
	.debuginfo complex-type (local-sym "_stage_index" 1 "waveform_perfect_model_gemini.c" 122 (basetype 1 unsigned) split "r0x1008")
	.debuginfo complex-type (local-sym "_bit_offset" 1 "waveform_perfect_model_gemini.c" 127 (basetype 1 unsigned) split "r0x1009")
	.debuginfo complex-type (local-sym "_byte_idx" 1 "waveform_perfect_model_gemini.c" 128 (basetype 1 unsigned) split "r0x100A")
	.debuginfo complex-type (local-sym "_shift" 1 "waveform_perfect_model_gemini.c" 129 (basetype 1 unsigned) split "r0x1009")
	.debuginfo complex-type (local-sym "_code" 1 "waveform_perfect_model_gemini.c" 130 (basetype 1 unsigned) split "r0x100A")
	.debuginfo complex-type (local-sym "_shape" 2 "waveform_perfect_model_gemini.c" 124 (pointer rom 2 (basetype 1 unsigned)) split "r0x1009" "r0x100A")
	.debuginfo complex-type (local-sym "_long_s" 2 "waveform_perfect_model_gemini.c" 125 (basetype 2 unsigned) split "r0x100B" "r0x100C")
	.debuginfo complex-type (local-sym "_pulse" 1 "waveform_perfect_model_gemini.c" 126 (basetype 1 unsigned) split "r0x100D")
	.debuginfo complex-type (local-sym "_total_s" 2 "waveform_perfect_model_gemini.c" 131 (basetype 2 unsigned) split "r0x1011" "r0x1012")
_waveform_model_load_stage:
; 2 exit points
	.line	122, "waveform_perfect_model_gemini.c"; 	void waveform_model_load_stage(uint8_t model_id, uint8_t stage_index)
	BANKSEL	r0x1007
	MOVAR	r0x1007
	MOVR	STK00,W
	BANKSEL	r0x1008
	MOVAR	r0x1008
	.line	134, "waveform_perfect_model_gemini.c"; 	if (model_id == MODEL_ID_MOVANO_LOCAL)
	BANKSEL	r0x1007
	MOVR	r0x1007,W
	XORIA	0x0e
	BTRSS	STATUS,2
	MGOTO	_02019_DS_
;;unsigned compare: left < lit(0x2D=45), size=1
	.line	136, "waveform_perfect_model_gemini.c"; 	if (stage_index < 45U)
	MOVIA	0x2d
	BANKSEL	r0x1008
	SUBAR	r0x1008,W
	BTRSC	STATUS,0
	MGOTO	_02006_DS_
	.line	138, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 16U;
	MOVIA	0x10
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	139, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 17U;
	MOVIA	0x11
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	.line	140, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
_02006_DS_:
	.line	143, "waveform_perfect_model_gemini.c"; 	if (stage_index == 45U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x2d
	BTRSS	STATUS,2
	MGOTO	_02008_DS_
	.line	145, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 48U;
	MOVIA	0x30
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	146, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 49U;
	MOVIA	0x31
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	.line	147, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
;;unsigned compare: left < lit(0x31=49), size=1
_02008_DS_:
	.line	150, "waveform_perfect_model_gemini.c"; 	if (stage_index < 49U)
	MOVIA	0x31
	BANKSEL	r0x1008
	SUBAR	r0x1008,W
	BTRSC	STATUS,0
	MGOTO	_02013_DS_
	.line	152, "waveform_perfect_model_gemini.c"; 	if (stage_index == 46U)
	MOVR	r0x1008,W
	XORIA	0x2e
	BTRSS	STATUS,2
	MGOTO	_02010_DS_
	.line	154, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 16U;
	MOVIA	0x10
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	155, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 17U;
	MOVIA	0x11
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	MGOTO	_02011_DS_
_02010_DS_:
	.line	159, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 32U;
	MOVIA	0x20
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	160, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 33U;
	MOVIA	0x21
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
_02011_DS_:
	.line	162, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
_02013_DS_:
	.line	165, "waveform_perfect_model_gemini.c"; 	if (stage_index == 87U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x57
	BTRSS	STATUS,2
	MGOTO	_02015_DS_
	.line	167, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 16U;
	MOVIA	0x10
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	168, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 501U;
	MOVIA	0xf5
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x01
	MOVAR	(_g_stage_off_steps + 1)
	.line	169, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
_02015_DS_:
	.line	172, "waveform_perfect_model_gemini.c"; 	bit_offset = (uint8_t)(stage_index - 49U);
	MOVIA	0xcf
	BANKSEL	r0x1008
	ADDAR	r0x1008,W
	BANKSEL	r0x1009
	MOVAR	r0x1009
	.line	173, "waveform_perfect_model_gemini.c"; 	byte_idx = (uint8_t)(bit_offset >> 2);
	BCR	STATUS,0
	RRR	r0x1009,W
	BANKSEL	r0x100A
	MOVAR	r0x100A
	BCR	STATUS,0
	RRR	r0x100A,F
	.line	174, "waveform_perfect_model_gemini.c"; 	shift = (uint8_t)((bit_offset & 0x03U) << 1);
	MOVIA	0x03
	BANKSEL	r0x1009
	ANDAR	r0x1009,F
	BCR	STATUS,0
	RLR	r0x1009,F
	.line	175, "waveform_perfect_model_gemini.c"; 	code = (uint8_t)((c_movano_payload[byte_idx] >> shift) & 0x03U);
	MOVIA	(_c_movano_payload + 0)
	BANKSEL	r0x100A
	ADDAR	r0x100A,F
	MOVIA	((_c_movano_payload + 0) >> 8) & 0xff
	ADCIA	0x00
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100A
	MOVR	r0x100A,W
	MOVAR	STK01
	BANKSEL	r0x100B
	MOVR	r0x100B,W
	MOVAR	STK00
	MOVIA	0x80
	MCALL	__gptrget1
	BANKSEL	r0x100C
	MOVAR	r0x100C
	BANKSEL	r0x100A
	MOVAR	r0x100A
	BANKSEL	r0x1009
	MOVR	r0x1009,W
	SUBIA	0x00
	BTRSC	STATUS,2
	MGOTO	_02220_DS_
_02219_DS_:
	BANKSEL	r0x100A
	RRR	r0x100A,F
	ADDIA	0x01
	BTRSS	STATUS,0
	MGOTO	_02219_DS_
_02220_DS_:
	MOVIA	0x03
	BANKSEL	r0x100A
	ANDAR	r0x100A,F
	.line	177, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = ((code & 0x02U) != 0U) ? 32U : 16U;
	MOVIA	0x02
	ANDAR	r0x100A,W
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVR	r0x1009,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x100B
	MOVAR	r0x100B
	MOVR	r0x100B,W
	BTRSS	STATUS,2
	MGOTO	_02080_DS_
	MOVIA	0x20
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MGOTO	_02081_DS_
_02080_DS_:
	MOVIA	0x10
	BANKSEL	r0x1009
	MOVAR	r0x1009
_02081_DS_:
	BANKSEL	r0x1009
	MOVR	r0x1009,W
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	178, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = ((code & 0x01U) != 0U) ? 34U : 17U;
	MOVIA	0x01
	BANKSEL	r0x100A
	ANDAR	r0x100A,F
	MOVR	r0x100A,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVR	r0x1009,W
	BTRSS	STATUS,2
	MGOTO	_02082_DS_
	MOVIA	0x22
	MOVAR	r0x1009
	MGOTO	_02083_DS_
_02082_DS_:
	MOVIA	0x11
	BANKSEL	r0x1009
	MOVAR	r0x1009
_02083_DS_:
	BANKSEL	r0x1009
	MOVR	r0x1009,W
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	.line	179, "waveform_perfect_model_gemini.c"; 	if (stage_index == 65U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x41
	BTRSS	STATUS,2
	MGOTO	_02017_DS_
	.line	181, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 32U;
	MOVIA	0x20
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	182, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 18U;
	MOVIA	0x12
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
_02017_DS_:
	.line	184, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
_02019_DS_:
	.line	188, "waveform_perfect_model_gemini.c"; 	if (model_id == MODEL_ID_VIBE_LOCAL)
	BANKSEL	r0x1007
	MOVR	r0x1007,W
	XORIA	0x0f
	BTRSS	STATUS,2
	MGOTO	_02032_DS_
	.line	190, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 1250U;
	MOVIA	0xe2
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x04
	MOVAR	(_g_stage_on_steps + 1)
	.line	191, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 1250U;
	MOVIA	0xe2
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x04
	MOVAR	(_g_stage_off_steps + 1)
	.line	193, "waveform_perfect_model_gemini.c"; 	if (stage_index == 0U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	BTRSS	STATUS,2
	MGOTO	_02029_DS_
	.line	195, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 25000U;
	MOVIA	0xa8
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x61
	MOVAR	(_g_stage_on_steps + 1)
	.line	196, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 2500U;
	MOVIA	0xc4
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x09
	MOVAR	(_g_stage_off_steps + 1)
	MGOTO	_02030_DS_
_02029_DS_:
	.line	198, "waveform_perfect_model_gemini.c"; 	else if (stage_index == 1U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x01
	BTRSS	STATUS,2
	MGOTO	_02026_DS_
	.line	200, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 2500U;
	MOVIA	0xc4
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x09
	MOVAR	(_g_stage_on_steps + 1)
	MGOTO	_02030_DS_
_02026_DS_:
	.line	202, "waveform_perfect_model_gemini.c"; 	else if (stage_index == 4U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x04
	BTRSS	STATUS,2
	MGOTO	_02023_DS_
	.line	204, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 2500U;
	MOVIA	0xc4
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x09
	MOVAR	(_g_stage_off_steps + 1)
	MGOTO	_02030_DS_
_02023_DS_:
	.line	206, "waveform_perfect_model_gemini.c"; 	else if (stage_index == 6U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x06
	BTRSS	STATUS,2
	MGOTO	_02030_DS_
	.line	208, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 2500U;
	MOVIA	0xc4
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	MOVIA	0x09
	MOVAR	(_g_stage_on_steps + 1)
	.line	209, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 37500U;
	MOVIA	0x7c
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	MOVIA	0x92
	MOVAR	(_g_stage_off_steps + 1)
_02030_DS_:
	.line	211, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0xE=14), size=1
_02032_DS_:
	.line	215, "waveform_perfect_model_gemini.c"; 	switch (model_id)
	MOVIA	0x0e
	BANKSEL	r0x1007
	SUBAR	r0x1007,W
	BTRSC	STATUS,0
	MGOTO	_02047_DS_
	MOVIA	((_02221_DS_ >> 8) & 0xff)
	MOVAR	PCHBUF
	MOVR	r0x1007,W
	ADDIA	_02221_DS_
	BTRSC	STATUS,0
	INCR	PCHBUF,F
	MOVAR	PCL
_02221_DS_:
	MGOTO	_02033_DS_
	MGOTO	_02034_DS_
	MGOTO	_02035_DS_
	MGOTO	_02036_DS_
	MGOTO	_02037_DS_
	MGOTO	_02038_DS_
	MGOTO	_02039_DS_
	MGOTO	_02040_DS_
	MGOTO	_02041_DS_
	MGOTO	_02042_DS_
	MGOTO	_02043_DS_
	MGOTO	_02044_DS_
	MGOTO	_02045_DS_
	MGOTO	_02046_DS_
_02033_DS_:
	.line	218, "waveform_perfect_model_gemini.c"; 	shape = c_shape_p0;
	MOVIA	(_c_shape_p0 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_p0 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	219, "waveform_perfect_model_gemini.c"; 	long_s = 304U;
	MOVIA	0x30
	BANKSEL	r0x100B
	MOVAR	r0x100B
	MOVIA	0x01
	BANKSEL	r0x100C
	MOVAR	r0x100C
	.line	220, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	221, "waveform_perfect_model_gemini.c"; 	bit_offset = 63U;
	MOVIA	0x3f
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	222, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02034_DS_:
	.line	224, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c1_c7;
	MOVIA	(_c_shape_c1_c7 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c1_c7 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	225, "waveform_perfect_model_gemini.c"; 	long_s = 128U;                 /* Final E */
	MOVIA	0x80
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	226, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	227, "waveform_perfect_model_gemini.c"; 	bit_offset = 62U;
	MOVIA	0x3e
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	228, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02035_DS_:
	.line	230, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c3_prefix;
	MOVIA	(_c_shape_c3_prefix + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c3_prefix + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	231, "waveform_perfect_model_gemini.c"; 	long_s = 240U;
	MOVIA	0xf0
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	232, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	233, "waveform_perfect_model_gemini.c"; 	bit_offset = 48U;
	MOVIA	0x30
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	234, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02036_DS_:
	.line	236, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c3_body;
	MOVIA	(_c_shape_c3_body + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c3_body + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	237, "waveform_perfect_model_gemini.c"; 	long_s = 256U;
	BANKSEL	r0x100B
	CLRR	r0x100B
	MOVIA	0x01
	BANKSEL	r0x100C
	MOVAR	r0x100C
	.line	238, "waveform_perfect_model_gemini.c"; 	pulse = 2U;
	MOVIA	0x02
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	239, "waveform_perfect_model_gemini.c"; 	bit_offset = 59U;
	MOVIA	0x3b
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	240, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02037_DS_:
	.line	242, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c4;
	MOVIA	(_c_shape_c4 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c4 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	243, "waveform_perfect_model_gemini.c"; 	long_s = 128U;                 /* Final E */
	MOVIA	0x80
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	244, "waveform_perfect_model_gemini.c"; 	pulse = 2U;
	MOVIA	0x02
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	245, "waveform_perfect_model_gemini.c"; 	bit_offset = 62U;
	MOVIA	0x3e
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	246, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02038_DS_:
	.line	248, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c5;
	MOVIA	(_c_shape_c5 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c5 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	249, "waveform_perfect_model_gemini.c"; 	long_s = 3300U;
	MOVIA	0xe4
	BANKSEL	r0x100B
	MOVAR	r0x100B
	MOVIA	0x0c
	BANKSEL	r0x100C
	MOVAR	r0x100C
	.line	250, "waveform_perfect_model_gemini.c"; 	pulse = 3U;
	MOVIA	0x03
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	251, "waveform_perfect_model_gemini.c"; 	bit_offset = 42U;
	MOVIA	0x2a
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	252, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02039_DS_:
	.line	254, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c6;
	MOVIA	(_c_shape_c6 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c6 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	255, "waveform_perfect_model_gemini.c"; 	long_s = 128U;                 /* Final E */
	MOVIA	0x80
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	256, "waveform_perfect_model_gemini.c"; 	pulse = 2U;
	MOVIA	0x02
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	257, "waveform_perfect_model_gemini.c"; 	bit_offset = 62U;
	MOVIA	0x3e
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	258, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02040_DS_:
	.line	260, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c1_c7;
	MOVIA	(_c_shape_c1_c7 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c1_c7 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	261, "waveform_perfect_model_gemini.c"; 	long_s = 128U;                 /* Final E */
	MOVIA	0x80
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	262, "waveform_perfect_model_gemini.c"; 	pulse = 2U;
	MOVIA	0x02
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	263, "waveform_perfect_model_gemini.c"; 	bit_offset = 62U;
	MOVIA	0x3e
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	264, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02041_DS_:
	.line	266, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c8_a;
	MOVIA	(_c_shape_c8_a + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c8_a + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	267, "waveform_perfect_model_gemini.c"; 	long_s = 288U;                 /* Penultimate L; final E handled below */
	MOVIA	0x20
	BANKSEL	r0x100B
	MOVAR	r0x100B
	MOVIA	0x01
	BANKSEL	r0x100C
	MOVAR	r0x100C
	.line	268, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	269, "waveform_perfect_model_gemini.c"; 	bit_offset = 76U;
	MOVIA	0x4c
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	270, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02042_DS_:
	.line	272, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c9_preamble_init;
	MOVIA	(_c_shape_c9_preamble_init + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c9_preamble_init + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	273, "waveform_perfect_model_gemini.c"; 	long_s = 0U;
	BANKSEL	r0x100B
	CLRR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	274, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	275, "waveform_perfect_model_gemini.c"; 	bit_offset = 51U;
	MOVIA	0x33
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	276, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02043_DS_:
	.line	278, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c9_preamble;
	MOVIA	(_c_shape_c9_preamble + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c9_preamble + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	279, "waveform_perfect_model_gemini.c"; 	long_s = 3760U;                /* Penultimate L; final E handled below */
	MOVIA	0xb0
	BANKSEL	r0x100B
	MOVAR	r0x100B
	MOVIA	0x0e
	BANKSEL	r0x100C
	MOVAR	r0x100C
	.line	280, "waveform_perfect_model_gemini.c"; 	pulse = 3U;
	MOVIA	0x03
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	281, "waveform_perfect_model_gemini.c"; 	bit_offset = 40U;
	MOVIA	0x28
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	282, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02044_DS_:
	.line	284, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c9_main_init;
	MOVIA	(_c_shape_c9_main_init + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c9_main_init + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	285, "waveform_perfect_model_gemini.c"; 	long_s = 192U;
	MOVIA	0xc0
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	286, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	287, "waveform_perfect_model_gemini.c"; 	bit_offset = 68U;
	MOVIA	0x44
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	288, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02045_DS_:
	.line	290, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c9_main;
	MOVIA	(_c_shape_c9_main + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c9_main + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	291, "waveform_perfect_model_gemini.c"; 	long_s = 3904U;
	MOVIA	0x40
	BANKSEL	r0x100B
	MOVAR	r0x100B
	MOVIA	0x0f
	BANKSEL	r0x100C
	MOVAR	r0x100C
	.line	292, "waveform_perfect_model_gemini.c"; 	pulse = 16U;
	MOVIA	0x10
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	293, "waveform_perfect_model_gemini.c"; 	bit_offset = 41U;
	MOVIA	0x29
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	294, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02046_DS_:
	.line	296, "waveform_perfect_model_gemini.c"; 	shape = c_shape_c11;
	MOVIA	(_c_shape_c11 + 0)
	BANKSEL	r0x1009
	MOVAR	r0x1009
	MOVIA	((_c_shape_c11 + 0) >> 8) & 0xff
	BANKSEL	r0x100A
	MOVAR	r0x100A
	.line	297, "waveform_perfect_model_gemini.c"; 	long_s = 0U;
	BANKSEL	r0x100B
	CLRR	r0x100B
	BANKSEL	r0x100C
	CLRR	r0x100C
	.line	298, "waveform_perfect_model_gemini.c"; 	pulse = 4U;
	MOVIA	0x04
	BANKSEL	r0x100D
	MOVAR	r0x100D
	.line	299, "waveform_perfect_model_gemini.c"; 	bit_offset = 54U;
	MOVIA	0x36
	BANKSEL	r0x100E
	MOVAR	r0x100E
	.line	300, "waveform_perfect_model_gemini.c"; 	break;
	MGOTO	_02048_DS_
_02047_DS_:
	.line	302, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = 0U;
	BANKSEL	_g_stage_on_steps
	CLRR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	303, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = 0U;
	BANKSEL	_g_stage_off_steps
	CLRR	_g_stage_off_steps
	CLRR	(_g_stage_off_steps + 1)
	.line	304, "waveform_perfect_model_gemini.c"; 	return;
	MGOTO	_02078_DS_
_02048_DS_:
	.line	308, "waveform_perfect_model_gemini.c"; 	if (((model_id == (uint8_t)MODEL_ID_C8_A) && (stage_index == 75U)) ||
	BANKSEL	r0x100F
	CLRR	r0x100F
	BANKSEL	r0x1007
	MOVR	r0x1007,W
	XORIA	0x08
	BTRSS	STATUS,2
	MGOTO	_00001_DS_
	BANKSEL	r0x100F
	INCR	r0x100F,F
_00001_DS_:
	BANKSEL	r0x100F
	MOVR	r0x100F,W
	BTRSC	STATUS,2
	MGOTO	_02067_DS_
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x4b
	BTRSC	STATUS,2
	MGOTO	_02062_DS_
_02067_DS_:
	.line	309, "waveform_perfect_model_gemini.c"; 	((model_id == (uint8_t)MODEL_ID_C9_PREAMBLE) && (stage_index == 39U)))
	BANKSEL	r0x1010
	CLRR	r0x1010
	BANKSEL	r0x1007
	MOVR	r0x1007,W
	XORIA	0x0a
	BTRSS	STATUS,2
	MGOTO	_00002_DS_
	BANKSEL	r0x1010
	INCR	r0x1010,F
_00002_DS_:
	BANKSEL	r0x1010
	MOVR	r0x1010,W
	BTRSC	STATUS,2
	MGOTO	_02063_DS_
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x27
	BTRSS	STATUS,2
	MGOTO	_02063_DS_
_02062_DS_:
	.line	311, "waveform_perfect_model_gemini.c"; 	total_s = long_s;
	BANKSEL	r0x100B
	MOVR	r0x100B,W
	BANKSEL	r0x1011
	MOVAR	r0x1011
	BANKSEL	r0x100C
	MOVR	r0x100C,W
	BANKSEL	r0x1012
	MOVAR	r0x1012
	MGOTO	_02064_DS_
_02063_DS_:
	.line	313, "waveform_perfect_model_gemini.c"; 	else if (((model_id == (uint8_t)MODEL_ID_C8_A) && (stage_index == 76U)) ||
	BANKSEL	r0x100F
	MOVR	r0x100F,W
	BTRSC	STATUS,2
	MGOTO	_02061_DS_
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x4c
	BTRSC	STATUS,2
	MGOTO	_02056_DS_
_02061_DS_:
	.line	314, "waveform_perfect_model_gemini.c"; 	((model_id == (uint8_t)MODEL_ID_C9_PREAMBLE) && (stage_index == 40U)))
	BANKSEL	r0x1010
	MOVR	r0x1010,W
	BTRSC	STATUS,2
	MGOTO	_02057_DS_
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x28
	BTRSS	STATUS,2
	MGOTO	_02057_DS_
_02056_DS_:
	.line	316, "waveform_perfect_model_gemini.c"; 	total_s = 128U;
	MOVIA	0x80
	BANKSEL	r0x1011
	MOVAR	r0x1011
	BANKSEL	r0x1012
	CLRR	r0x1012
	MGOTO	_02064_DS_
_02057_DS_:
	.line	318, "waveform_perfect_model_gemini.c"; 	else if ((long_s != 0U) && (stage_index == bit_offset))
	BANKSEL	r0x100C
	MOVR	r0x100C,W
	BANKSEL	r0x100B
	IORAR	r0x100B,W
	BTRSC	STATUS,2
	MGOTO	_02053_DS_
	BANKSEL	r0x100E
	MOVR	r0x100E,W
	BANKSEL	r0x1008
	XORAR	r0x1008,W
	BTRSS	STATUS,2
	MGOTO	_02053_DS_
	.line	320, "waveform_perfect_model_gemini.c"; 	total_s = long_s;
	BANKSEL	r0x100B
	MOVR	r0x100B,W
	BANKSEL	r0x1011
	MOVAR	r0x1011
	BANKSEL	r0x100C
	MOVR	r0x100C,W
	BANKSEL	r0x1012
	MOVAR	r0x1012
	MGOTO	_02064_DS_
_02053_DS_:
	.line	325, "waveform_perfect_model_gemini.c"; 	byte_idx = (uint8_t)(stage_index >> 2);
	BCR	STATUS,0
	BANKSEL	r0x1008
	RRR	r0x1008,W
	BANKSEL	r0x100B
	MOVAR	r0x100B
	BCR	STATUS,0
	RRR	r0x100B,F
	.line	326, "waveform_perfect_model_gemini.c"; 	shift = (uint8_t)((stage_index & 0x03U) << 1);
	MOVIA	0x03
	BANKSEL	r0x1008
	ANDAR	r0x1008,W
	BANKSEL	r0x100C
	MOVAR	r0x100C
	BCR	STATUS,0
	RLR	r0x100C,F
	.line	327, "waveform_perfect_model_gemini.c"; 	code = (uint8_t)((shape[byte_idx] >> shift) & 0x03U);
	BANKSEL	r0x1009
	MOVR	r0x1009,W
	BANKSEL	r0x100B
	ADDAR	r0x100B,F
	BANKSEL	r0x100A
	MOVR	r0x100A,W
	ADCIA	0x00
	BANKSEL	r0x100E
	MOVAR	r0x100E
	BANKSEL	r0x100B
	MOVR	r0x100B,W
	MOVAR	STK01
	BANKSEL	r0x100E
	MOVR	r0x100E,W
	MOVAR	STK00
	MOVIA	0x80
	MCALL	__gptrget1
	BANKSEL	r0x1009
	MOVAR	r0x1009
	BANKSEL	r0x100A
	MOVAR	r0x100A
	BANKSEL	r0x100C
	MOVR	r0x100C,W
	SUBIA	0x00
	BTRSC	STATUS,2
	MGOTO	_02227_DS_
_02226_DS_:
	BANKSEL	r0x100A
	RRR	r0x100A,F
	ADDIA	0x01
	BTRSS	STATUS,0
	MGOTO	_02226_DS_
_02227_DS_:
	MOVIA	0x03
	BANKSEL	r0x100A
	ANDAR	r0x100A,F
	.line	329, "waveform_perfect_model_gemini.c"; 	if (code == 3U)
	MOVR	r0x100A,W
	XORIA	0x03
	BTRSS	STATUS,2
	MGOTO	_02050_DS_
	.line	331, "waveform_perfect_model_gemini.c"; 	total_s = 96U;                 /* D */
	MOVIA	0x60
	BANKSEL	r0x1011
	MOVAR	r0x1011
	BANKSEL	r0x1012
	CLRR	r0x1012
	MGOTO	_02064_DS_
_02050_DS_:
	.line	335, "waveform_perfect_model_gemini.c"; 	total_s = (uint16_t)(((uint16_t)code << 4) + 32U); /* A/B/C */
	BANKSEL	r0x100A
	MOVR	r0x100A,W
	BANKSEL	r0x1009
	MOVAR	r0x1009
	BANKSEL	r0x100B
	CLRR	r0x100B
	SWAPR	r0x100B,W
	ANDIA	0xf0
	BANKSEL	r0x100C
	MOVAR	r0x100C
	BANKSEL	r0x1009
	SWAPR	r0x1009,W
	BANKSEL	r0x100A
	MOVAR	r0x100A
	ANDIA	0x0f
	BANKSEL	r0x100C
	IORAR	r0x100C,F
	BANKSEL	r0x100A
	XORAR	r0x100A,F
	MOVIA	0x20
	ADDAR	r0x100A,W
	BANKSEL	r0x1011
	MOVAR	r0x1011
	MOVIA	0x00
	BANKSEL	r0x100C
	ADCAR	r0x100C,W
	BANKSEL	r0x1012
	MOVAR	r0x1012
_02064_DS_:
	.line	340, "waveform_perfect_model_gemini.c"; 	if (model_id == (uint8_t)MODEL_ID_C9_MAIN)
	BANKSEL	r0x1007
	MOVR	r0x1007,W
	XORIA	0x0c
	BTRSS	STATUS,2
	MGOTO	_02077_DS_
	.line	342, "waveform_perfect_model_gemini.c"; 	if (stage_index == 7U)
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x07
	BTRSS	STATUS,2
	MGOTO	_02074_DS_
	.line	344, "waveform_perfect_model_gemini.c"; 	pulse = 48U;                   /* D48 */
	MOVIA	0x30
	BANKSEL	r0x100D
	MOVAR	r0x100D
	MGOTO	_02077_DS_
_02074_DS_:
	.line	346, "waveform_perfect_model_gemini.c"; 	else if ((stage_index == 9U) || (stage_index == 10U) ||
	BANKSEL	r0x1008
	MOVR	r0x1008,W
	XORIA	0x09
	BTRSC	STATUS,2
	MGOTO	_02068_DS_
	MOVR	r0x1008,W
	XORIA	0x0a
	BTRSC	STATUS,2
	MGOTO	_02068_DS_
	.line	347, "waveform_perfect_model_gemini.c"; 	(stage_index == 25U) || (stage_index == 34U))
	MOVR	r0x1008,W
	XORIA	0x19
	BTRSC	STATUS,2
	MGOTO	_02068_DS_
	MOVR	r0x1008,W
	XORIA	0x22
	BTRSS	STATUS,2
	MGOTO	_02077_DS_
_02068_DS_:
	.line	349, "waveform_perfect_model_gemini.c"; 	pulse = 32U;                   /* C32, B32 */
	MOVIA	0x20
	BANKSEL	r0x100D
	MOVAR	r0x100D
_02077_DS_:
	.line	353, "waveform_perfect_model_gemini.c"; 	g_stage_on_steps = pulse;
	BANKSEL	r0x100D
	MOVR	r0x100D,W
	BANKSEL	_g_stage_on_steps
	MOVAR	_g_stage_on_steps
	CLRR	(_g_stage_on_steps + 1)
	.line	354, "waveform_perfect_model_gemini.c"; 	g_stage_off_steps = (uint16_t)(total_s - pulse);
	BANKSEL	r0x100D
	MOVR	r0x100D,W
	BANKSEL	r0x1007
	MOVAR	r0x1007
	BANKSEL	r0x1008
	CLRR	r0x1008
;;99	MOVR	r0x1007,W
	MOVIA	0x00
	BANKSEL	r0x100A
	MOVAR	r0x100A
;;100	MOVR	r0x1009,W
	BANKSEL	r0x100D
	MOVR	r0x100D,W
	BANKSEL	r0x1009
	MOVAR	r0x1009
	BANKSEL	r0x1011
	SUBAR	r0x1011,W
	BANKSEL	_g_stage_off_steps
	MOVAR	_g_stage_off_steps
	BANKSEL	r0x100A
	MOVR	r0x100A,W
	BANKSEL	r0x1012
	SBCAR	r0x1012,W
	BANKSEL	_g_stage_off_steps
	MOVAR	(_g_stage_off_steps + 1)
_02078_DS_:
	.line	355, "waveform_perfect_model_gemini.c"; 	}
	RETURN	
; exit point of _waveform_model_load_stage


;	code size estimation:
;	  836+  273 =  1109 instructions ( 2764 byte)

	end
