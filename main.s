;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.2.2 #0 (MSVC)
;--------------------------------------------------------
; NY8A port
;--------------------------------------------------------
	.file	"main.c"
	list	p=NY8B062F,c=on
	#include "ny8b062f.inc"
	.debuginfo language C89
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_waveform_model_load_c10_stage
	extern	_waveform_model_load_stage
	extern	_waveform_model_get_stage_count
	extern	_clear_ram
	extern	_multi_16b
	extern	_multi_8b
	extern	_T0MD
	extern	_PCON1
	extern	_CMPCR
	extern	_BODCON
	extern	_PS0CV
	extern	_APHCON
	extern	_IOSTB
	extern	_IOSTA
	extern	_PWM4DUTY
	extern	_P4CR1
	extern	_BZ3CR
	extern	_PS3CV
	extern	_PWM3DUTY
	extern	_T3CR2
	extern	_T3CR1
	extern	_TMR3
	extern	_OSCCR
	extern	_BZ2CR
	extern	_PS2CV
	extern	_PWM2DUTY
	extern	_T2CR2
	extern	_T2CR1
	extern	_TMR2
	extern	_TBHD
	extern	_TBHP
	extern	_IRCR
	extern	_BZ1CR
	extern	_PS1CV
	extern	_PWM1DUTY
	extern	_T1CR2
	extern	_T1CR1
	extern	_TMR1
	extern	_ADD
	extern	_PCHBUF
	extern	_STATUS
	extern	_PCL
	extern	_TMR0
	extern	_g_stage_off_steps
	extern	_g_stage_on_steps
	extern	_INTE2bits
	extern	_TM3RHbits
	extern	_RFCbits
	extern	_ANAENbits
	extern	_TMRHbits
	extern	_INTEDGbits
	extern	_ADJMDbits
	extern	_PACONbits
	extern	_AWUCONbits
	extern	_ADCRbits
	extern	_ADVREFHbits
	extern	_ADRbits
	extern	_ADMDbits
	extern	_INTFbits
	extern	_INTEbits
	extern	_BPHCONbits
	extern	_ABPLCONbits
	extern	_BWUCONbits
	extern	_PCONbits
	extern	_PORTBbits
	extern	_PORTAbits
	extern	__gptrput1
	extern	__gptrget1
	extern	__nyc_ny8_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	extern	_main
	extern	_isr
	extern	_INTE2
	extern	_TM3RH
	extern	_RFC
	extern	_ANAEN
	extern	_TMRH
	extern	_INTEDG
	extern	_ADJMD
	extern	_PACON
	extern	_AWUCON
	extern	_ADCR
	extern	_ADVREFH
	extern	_ADR
	extern	_ADMD
	extern	_INTF
	extern	_INTE
	extern	_BPHCON
	extern	_ABPLCON
	extern	_BWUCON
	extern	_PCON
	extern	_PORTB
	extern	_PORTA

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

.segment "share_bank"
PSAVE:
	.res 1
.segment "share_bank"
SSAVE:
	.res 1
.segment "share_bank"
WSAVE:
	.res 1
.segment "share_bank"
___STK12:
STK12:
	.res 1
.segment "share_bank"
___STK11:
STK11:
	.res 1
.segment "share_bank"
___STK10:
STK10:
	.res 1
.segment "share_bank"
___STK09:
STK09:
	.res 1
.segment "share_bank"
___STK08:
STK08:
	.res 1
.segment "share_bank"
___STK07:
STK07:
	.res 1
.segment "share_bank"
___STK06:
STK06:
	.res 1
.segment "share_bank"
___STK05:
STK05:
	.res 1
.segment "share_bank"
___STK04:
STK04:
	.res 1
.segment "share_bank"
___STK03:
STK03:
	.res 1
.segment "share_bank"
___STK02:
STK02:
	.res 1
.segment "share_bank"
___STK01:
STK01:
	.res 1
.segment "share_bank"
___STK00:
STK00:
	.res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
.segment "uninit"
_s_entry_timer_10ms:
	.res 2
	.debuginfo complex-type (symbol "_s_entry_timer_10ms" 2 local "main.c" 81 (basetype 2 unsigned))

.segment "uninit"
_s_entry_index:
	.res 1
	.debuginfo complex-type (symbol "_s_entry_index" 1 local "main.c" 82 (basetype 1 unsigned))

.segment "uninit"
_s_entry_expired:
	.res 1
	.debuginfo complex-type (symbol "_s_entry_expired" 1 local "main.c" 83 (basetype 1 unsigned))

.segment "uninit"
_s_running:
	.res 1
	.debuginfo complex-type (symbol "_s_running" 1 local "main.c" 84 (basetype 1 unsigned))

.segment "uninit"
_s_current_entry_mode:
	.res 1
	.debuginfo complex-type (symbol "_s_current_entry_mode" 1 local "main.c" 87 (basetype 1 unsigned))

.segment "uninit"
_s_current_model_id:
	.res 1
	.debuginfo complex-type (symbol "_s_current_model_id" 1 local "main.c" 88 (basetype 1 unsigned))

.segment "uninit"
_s_current_stage_count:
	.res 1
	.debuginfo complex-type (symbol "_s_current_stage_count" 1 local "main.c" 89 (basetype 1 unsigned))

.segment "uninit"
_s_active_rem:
	.res 2
	.debuginfo complex-type (symbol "_s_active_rem" 2 local "main.c" 92 (basetype 2 unsigned))

.segment "uninit"
_s_inactive_rem:
	.res 2
	.debuginfo complex-type (symbol "_s_inactive_rem" 2 local "main.c" 93 (basetype 2 unsigned))

.segment "uninit"
_s_current_phase:
	.res 1
	.debuginfo complex-type (symbol "_s_current_phase" 1 local "main.c" 94 (basetype 1 unsigned))

.segment "uninit"
_s_queued_phase:
	.res 1
	.debuginfo complex-type (symbol "_s_queued_phase" 1 local "main.c" 95 (basetype 1 unsigned))

.segment "uninit"
_s_has_queued_chunk:
	.res 1
	.debuginfo complex-type (symbol "_s_has_queued_chunk" 1 local "main.c" 96 (basetype 1 unsigned))

.segment "uninit"
_s_prep_inactive_steps:
	.res 1
	.debuginfo complex-type (symbol "_s_prep_inactive_steps" 1 local "main.c" 99 (basetype 1 unsigned))

.segment "uninit"
_s_prep_tmrh:
	.res 1
	.debuginfo complex-type (symbol "_s_prep_tmrh" 1 local "main.c" 100 (basetype 1 unsigned))

.segment "uninit"
_s_prep_tmr2:
	.res 1
	.debuginfo complex-type (symbol "_s_prep_tmr2" 1 local "main.c" 101 (basetype 1 unsigned))

.segment "uninit"
_s_stage_index:
	.res 1
	.debuginfo complex-type (symbol "_s_stage_index" 1 local "main.c" 104 (basetype 1 unsigned))

.segment "uninit"
_s_c10_phase:
	.res 1
	.debuginfo complex-type (symbol "_s_c10_phase" 1 local "main.c" 105 (basetype 1 unsigned))

.segment "uninit"
_s_c10_round:
	.res 1
	.debuginfo complex-type (symbol "_s_c10_round" 1 local "main.c" 106 (basetype 1 unsigned))

.segment "uninit"
_s_c10_stage:
	.res 1
	.debuginfo complex-type (symbol "_s_c10_stage" 1 local "main.c" 107 (basetype 1 unsigned))

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
.segment "uninit"
r0x101F:
	.res	1
.segment "uninit"
r0x1020:
	.res	1
.segment "uninit"
r0x1021:
	.res	1
.segment "uninit"
r0x1022:
	.res	1
.segment "uninit"
r0x1023:
	.res	1
.segment "uninit"
r0x1024:
	.res	1
.segment "uninit"
r0x1025:
	.res	1
.segment "uninit"
r0x1026:
	.res	1
.segment "uninit"
r0x1027:
	.res	1
.segment "uninit"
r0x1028:
	.res	1
.segment "uninit"
r0x102A:
	.res	1
.segment "uninit"
r0x102B:
	.res	1
.segment "uninit"
r0x102C:
	.res	1
.segment "uninit"
r0x102D:
	.res	1
.segment "uninit"
r0x102E:
	.res	1
.segment "uninit"
r0x1030:
	.res	1
.segment "uninit"
r0x102F:
	.res	1
.segment "uninit"
r0x1031:
	.res	1
.segment "uninit"
r0x1032:
	.res	1
.segment "uninit"
r0x1029:
	.res	1
.segment "uninit"
_load_playlist_entry_standard_stage_index_65536_63:
	.res	1
	.debuginfo complex-type (symbol "_load_playlist_entry_standard_stage_index_65536_63" 1 global "" 0 (basetype 1 unsigned))
.segment "uninit"
_service_timer2_underflow_standard_stage_index_65536_83:
	.res	1
	.debuginfo complex-type (symbol "_service_timer2_underflow_standard_stage_index_65536_83" 1 global "" 0 (basetype 1 unsigned))
.segment "uninit"
___sdcc_saved_fsr:
	.res	1
	.debuginfo complex-type (symbol "___sdcc_saved_fsr" 1 global "" 0 (basetype 1 unsigned))
.segment "uninit"
___sdcc_saved_stk00:
	.res	1
	.debuginfo complex-type (symbol "___sdcc_saved_stk00" 1 global "" 0 (basetype 1 unsigned))
.segment "uninit"
___sdcc_saved_stk01:
	.res	1
	.debuginfo complex-type (symbol "___sdcc_saved_stk01" 1 global "" 0 (basetype 1 unsigned))
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

.segment "code"
_c_playlist:
	retia 0x19	; 25
	retia 0x2e	; 46
	retia 0x58	; 88	'X'
	retia 0x19	; 25
	retia 0x2f	; 47
	retia 0x07	; 7
	retia 0x0a	; 10
	retia 0x00	; 0
	retia 0x40	; 64
	retia 0x19	; 25
	retia 0x01	; 1
	retia 0x3f	; 63
	retia 0x19	; 25
	retia 0xa0	; 160
	retia 0x00	; 0
	retia 0x06	; 6
	retia 0x02	; 2
	retia 0x31	; 49	'1'
	retia 0x19	; 25
	retia 0x03	; 3
	retia 0x3c	; 60
	retia 0x19	; 25
	retia 0x04	; 4
	retia 0x3f	; 63
	retia 0x19	; 25
	retia 0x05	; 5
	retia 0x2b	; 43
	retia 0x19	; 25
	retia 0x06	; 6
	retia 0x3f	; 63
	retia 0x19	; 25
	retia 0x07	; 7
	retia 0x3f	; 63
	retia 0x05	; 5
	retia 0x80	; 128
	retia 0x00	; 0
	retia 0x05	; 5
	retia 0x08	; 8
	retia 0x4d	; 77	'M'
	retia 0x00	; 0
	retia 0x49	; 73	'I'
	retia 0x34	; 52	'4'
	retia 0x0a	; 10
	retia 0x0a	; 10
	retia 0x29	; 41
	retia 0x00	; 0
	retia 0x4b	; 75	'K'
	retia 0x45	; 69	'E'
	retia 0x19	; 25
	retia 0x0c	; 12
	retia 0x2a	; 42
	retia 0x0a	; 10
	retia 0x80	; 128
	retia 0x00	; 0
	retia 0x19	; 25
	retia 0xe0	; 224
	retia 0x00	; 0
	retia 0x19	; 25
	retia 0x0d	; 13
	retia 0x37	; 55	'7'
;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
ORG	0x0000
	LGOTO	__nyc_ny8_startup
;--------------------------------------------------------
; interrupt and initialization code
;--------------------------------------------------------
ORG 0x0008
	MGOTO	__sdcc_interrupt

.segment "code"
__sdcc_interrupt:
;***
;  pBlock Stats: dbName = I
;***
;functions called:
;   _service_timer2_underflow
;   _service_timer2_underflow
;   _service_timer2_underflow
;   _service_timer2_underflow
;4 compiler assigned registers:
;   STK00
;   STK01
;   r0x1031
;   r0x1032
;; Starting pCode block
_isr:
; 0 exit points
	.line	683, "main.c"; 	void isr(void) __interrupt(0)
	MOVAR	WSAVE
	SWAPR	STATUS,W
	CLRR	STATUS
	MOVAR	SSAVE
	MOVR	PCHBUF,W
	CLRR	PCHBUF
	MOVAR	PSAVE
	MOVR	FSR,W
	BANKSEL	___sdcc_saved_fsr
	MOVAR	___sdcc_saved_fsr
	MOVR	STK00,W
	BANKSEL	___sdcc_saved_stk00
	MOVAR	___sdcc_saved_stk00
	MOVR	STK01,W
	BANKSEL	___sdcc_saved_stk01
	MOVAR	___sdcc_saved_stk01
	.line	686, "main.c"; 	if (INTFbits.T2IF)
	BTRSC	_INTFbits,5
	.line	688, "main.c"; 	service_timer2_underflow();
	MCALL	_service_timer2_underflow
	.line	692, "main.c"; 	if (INTFbits.T1IF)
	BTRSS	_INTFbits,3
	MGOTO	_02262_DS_
	.line	694, "main.c"; 	INTFbits.T1IF = 0;
	MOVIA	0xf7
	MOVAR	(_INTFbits + 0)
	.line	695, "main.c"; 	if (s_running != 0U)
	BANKSEL	_s_running
	MOVR	_s_running,W
	BTRSC	STATUS,2
	MGOTO	_02262_DS_
	.line	697, "main.c"; 	if (s_entry_timer_10ms != 0U)
	BANKSEL	_s_entry_timer_10ms
	MOVR	(_s_entry_timer_10ms + 1),W
	IORAR	_s_entry_timer_10ms,W
	BTRSC	STATUS,2
	MGOTO	_02262_DS_
	.line	699, "main.c"; 	s_entry_timer_10ms--;
	MOVR	_s_entry_timer_10ms,W
	BANKSEL	r0x1031
	MOVAR	r0x1031
	BANKSEL	_s_entry_timer_10ms
	MOVR	(_s_entry_timer_10ms + 1),W
	BANKSEL	r0x1032
	MOVAR	r0x1032
	MOVIA	0xff
	BANKSEL	r0x1031
	ADDAR	r0x1031,W
	BANKSEL	_s_entry_timer_10ms
	MOVAR	_s_entry_timer_10ms
	MOVIA	0xff
	BANKSEL	r0x1032
	ADCAR	r0x1032,W
	BANKSEL	_s_entry_timer_10ms
	MOVAR	(_s_entry_timer_10ms + 1)
	.line	700, "main.c"; 	if (s_entry_timer_10ms == 0U)
	MOVR	(_s_entry_timer_10ms + 1),W
	IORAR	_s_entry_timer_10ms,W
	BTRSS	STATUS,2
	MGOTO	_02262_DS_
	.line	702, "main.c"; 	s_entry_expired = 1U;
	MOVIA	0x01
	BANKSEL	_s_entry_expired
	MOVAR	_s_entry_expired
_02262_DS_:
	.line	709, "main.c"; 	if (INTFbits.WDTIF)
	BTRSS	_INTFbits,6
	MGOTO	_02264_DS_
	.line	711, "main.c"; 	INTF = (uint8_t)~C_INT_WDT;
	MOVIA	0xbf
	MOVAR	_INTF
_02264_DS_:
	.line	715, "main.c"; 	if (INTFbits.T2IF)
	BTRSS	_INTFbits,5
	MGOTO	_02267_DS_
	.line	717, "main.c"; 	service_timer2_underflow();
	MCALL	_service_timer2_underflow
_02267_DS_:
	.line	719, "main.c"; 	}
	BANKSEL	___sdcc_saved_stk01
	MOVR	___sdcc_saved_stk01,W
	MOVAR	STK01
	BANKSEL	___sdcc_saved_stk00
	MOVR	___sdcc_saved_stk00,W
	MOVAR	STK00
	BANKSEL	___sdcc_saved_fsr
	MOVR	___sdcc_saved_fsr,W
	MOVAR	FSR
	MOVR	PSAVE,W
	MOVAR	PCHBUF
	CLRR	STATUS
	SWAPR	SSAVE,W
	MOVAR	STATUS
	SWAPR	WSAVE,F
	SWAPR	WSAVE,W
END_OF_INTERRUPT:
	RETIE	

;--------------------------------------------------------
; code
;--------------------------------------------------------
; code_main	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _gpio_init
;   _legacy_peripherals_disable
;   _pwm3_init
;   _timer1_init
;   _timer2_init
;   _interrupt_init
;   _load_playlist_entry
;   _pwm3_set_enabled
;   _load_playlist_entry
;   _load_playlist_entry
;   _pwm3_set_enabled
;   _load_playlist_entry
;1 compiler assigned register :
;   r0x1029
;; Starting pCode block
.segment "code"; module=main, function=_main
	.debuginfo subprogram _main
_main:
; 2 exit points
	.line	726, "main.c"; 	DISI();
	DISI
	.line	727, "main.c"; 	PCON = C_WDT_En | C_LVR_En;
	MOVIA	0x88
	MOVAR	_PCON
_gpio_init:
	.line	122, "main.c"; 	APHCON = (uint8_t)~C_PA0_PHB;
	MOVIA	0xfe
	IOST	_APHCON
	.line	123, "main.c"; 	IOSTA = C_PA7_Output | C_PA5_Output | C_PA4_Input | C_PA2_Output | C_PA0_Output;
	MOVIA	0x10
	IOST	_IOSTA
	.line	124, "main.c"; 	PORTA = (PIN_MASK_PA7_GREEN_LED | PIN_MASK_PA5_RED_LED | PIN_MASK_PA0_POWER_HOLD);
	MOVIA	0xa1
	MOVAR	_PORTA
	.line	126, "main.c"; 	IOSTB = C_PB3_Input;
	MOVIA	0x08
	IOST	_IOSTB
	.line	127, "main.c"; 	PORTB = 0x08U;
	MOVAR	_PORTB
	.line	730, "main.c"; 	PORTA |= PIN_MASK_PA0_POWER_HOLD;
	BSR	_PORTA,0
_legacy_peripherals_disable:
	.line	135, "main.c"; 	PCON1 = C_TMR0_Dis;
	CLRA	
	IOST	_PCON1
	.line	136, "main.c"; 	ADMD = 0x00U;
	CLRR	_ADMD
	.line	137, "main.c"; 	ADRbits.ADIE = 0;
	BCR	_ADRbits,6
	.line	138, "main.c"; 	ADRbits.ADIF = 0;
	BCR	_ADRbits,7
_pwm3_init:
	.line	146, "main.c"; 	TM3RH = 0x00U;
	CLRR	_TM3RH
	.line	147, "main.c"; 	TMR3 = 79U;         /* 80 instruction cycles = 8 us period (125 kHz) */
	MOVIA	0x4f
	SFUN	_TMR3
	.line	148, "main.c"; 	PWM3DUTY = 25U;     /* Default CP2 active cycles */
	MOVIA	0x19
	SFUN	_PWM3DUTY
	.line	149, "main.c"; 	T3CR2 = C_PS3_Dis | C_TMR3_ClkSrc_Inst;
	MOVIA	0x08
	SFUN	_T3CR2
	.line	150, "main.c"; 	T3CR1 = C_PWM3_Active_Hi | C_TMR3_Reload | C_TMR3_En;
	MOVIA	0x03
	SFUN	_T3CR1
	.line	151, "main.c"; 	PORTA = (PIN_MASK_PA7_GREEN_LED | PIN_MASK_PA5_RED_LED | PIN_MASK_PA0_POWER_HOLD);
	MOVIA	0xa1
	MOVAR	_PORTA
_timer1_init:
	.line	181, "main.c"; 	TMRH = (C_TMR1_Data_b9 | C_TMR1_Data_b8);
	MOVIA	0x30
	MOVAR	_TMRH
	.line	182, "main.c"; 	TMR1 = 0x0DU;
	MOVIA	0x0d
	SFUN	_TMR1
	.line	183, "main.c"; 	INTFbits.T1IF = 0;
	MOVIA	0xf7
	MOVAR	(_INTFbits + 0)
	.line	184, "main.c"; 	T1CR2 = C_TMR1_ClkSrc_Inst | C_PS1_EN | C_PS1_Div128;
	MOVIA	0x06
	SFUN	_T1CR2
	.line	185, "main.c"; 	T1CR1 = C_TMR1_Reload | C_TMR1_En;
	MOVIA	0x03
	SFUN	_T1CR1
_timer2_init:
	.line	193, "main.c"; 	T2CR1 = 0x00U;
	CLRA	
	SFUN	_T2CR1
	.line	194, "main.c"; 	T2CR2 = C_TMR2_ClkSrc_Inst | C_PS2_EN | C_PS2_Div4;
	MOVIA	0x01
	SFUN	_T2CR2
	.line	195, "main.c"; 	INTFbits.T2IF = 0;
	MOVIA	0xdf
	MOVAR	(_INTFbits + 0)
_interrupt_init:
	.line	203, "main.c"; 	INTF = 0x00U;
	CLRR	_INTF
	.line	204, "main.c"; 	INTE = C_INT_WDT | C_INT_TMR1 | C_INT_TMR2;
	MOVIA	0x68
	MOVAR	_INTE
	.line	738, "main.c"; 	s_running = 1U;
	MOVIA	0x01
	BANKSEL	_s_running
	MOVAR	_s_running
	.line	739, "main.c"; 	s_entry_index = 0U;
	BANKSEL	_s_entry_index
	CLRR	_s_entry_index
	.line	740, "main.c"; 	s_entry_expired = 0U;
	BANKSEL	_s_entry_expired
	CLRR	_s_entry_expired
	.line	741, "main.c"; 	load_playlist_entry(0U);
	MOVIA	0x00
	MCALL	_load_playlist_entry
	.line	743, "main.c"; 	ENI();
	ENI
_02280_DS_:
	.line	747, "main.c"; 	CLRWDT();
	clrwdt
	.line	750, "main.c"; 	if (s_entry_expired != 0U)
	BANKSEL	_s_entry_expired
	MOVR	_s_entry_expired,W
	BTRSC	STATUS,2
	MGOTO	_02280_DS_
	.line	752, "main.c"; 	DISI();
	DISI
	.line	753, "main.c"; 	if (s_entry_expired != 0U)
	BANKSEL	_s_entry_expired
	MOVR	_s_entry_expired,W
	BTRSC	STATUS,2
	MGOTO	_02276_DS_
	.line	755, "main.c"; 	s_entry_expired = 0U;
	CLRR	_s_entry_expired
	.line	756, "main.c"; 	s_entry_index++;
	BANKSEL	_s_entry_index
	MOVR	_s_entry_index,W
	BANKSEL	r0x1029
	MOVAR	r0x1029
	INCR	r0x1029,W
	BANKSEL	_s_entry_index
	MOVAR	_s_entry_index
;;unsigned compare: left < lit(0x14=20), size=1
	.line	757, "main.c"; 	if (s_entry_index >= PLAYLIST_ITEM_COUNT)
	MOVIA	0x14
	SUBAR	_s_entry_index,W
	BTRSS	STATUS,0
	MGOTO	_02273_DS_
	.line	759, "main.c"; 	s_running = 0U;
	BANKSEL	_s_running
	CLRR	_s_running
	.line	760, "main.c"; 	pwm3_set_enabled(false);
	MOVIA	0x00
	MCALL	_pwm3_set_enabled
	.line	761, "main.c"; 	T2CR1 = C_TMR2_Dis;
	CLRA	
	SFUN	_T2CR1
	.line	762, "main.c"; 	INTFbits.T2IF = 0;
	MOVIA	0xdf
	MOVAR	(_INTFbits + 0)
	.line	763, "main.c"; 	s_prep_inactive_steps = 0U;
	BANKSEL	_s_prep_inactive_steps
	CLRR	_s_prep_inactive_steps
	MGOTO	_02276_DS_
_02273_DS_:
	.line	767, "main.c"; 	load_playlist_entry(s_entry_index);
	BANKSEL	_s_entry_index
	MOVR	_s_entry_index,W
	MCALL	_load_playlist_entry
_02276_DS_:
	.line	770, "main.c"; 	ENI();
	ENI
	MGOTO	_02280_DS_
	.line	773, "main.c"; 	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _determine_next_chunk
;   _select_next_stage
;   _waveform_model_load_stage
;   _determine_next_chunk
;   _determine_next_chunk
;   _timer2_queue_interval
;   _timer2_queue_interval
;   _determine_next_chunk
;   _select_next_stage
;   _waveform_model_load_stage
;   _determine_next_chunk
;   _determine_next_chunk
;   _timer2_queue_interval
;   _timer2_queue_interval
;9 compiler assigned registers:
;   r0x102A
;   r0x102B
;   r0x102C
;   r0x102D
;   STK01
;   STK00
;   r0x102E
;   r0x102F
;   r0x1030
;; Starting pCode block
.segment "code"; module=main, function=_service_timer2_underflow
	.debuginfo subprogram _service_timer2_underflow
;local variable name mapping:
	.debuginfo complex-type (local-sym "_encoded" 1 "main.c" 543 (basetype 1 unsigned) split "r0x102A")
	.debuginfo complex-type (local-sym "_select_result" 1 "main.c" 541 (basetype 1 unsigned) split "r0x102B")
	.debuginfo complex-type (local-sym "_standard_stage_index" 1 "main.c" 542 (basetype 1 unsigned) link "_service_timer2_underflow_standard_stage_index_65536_83")
	.debuginfo complex-type (local-sym "_next_phase" 1 "main.c" 544 (basetype 1 unsigned) split "r0x102C")
	.debuginfo complex-type (local-sym "_next_chunk" 1 "main.c" 545 (basetype 1 unsigned) split "r0x102A")
	.debuginfo complex-type (local-sym "_prep_encoded" 1 "main.c" 546 (basetype 1 unsigned) split "r0x102B")
	.debuginfo complex-type (local-sym "_prep_steps" 1 "main.c" 547 (basetype 1 unsigned) split "r0x102B")
	.debuginfo complex-type (local-sym "_reload" 2 "main.c" 548 (basetype 2 unsigned) split "r0x1030" "r0x102F")
	.debuginfo complex-type (local-sym "_tmrh_val" 1 "main.c" 549 (basetype 1 unsigned) split "r0x102D")
_service_timer2_underflow:
; 2 exit points
	.line	551, "main.c"; 	INTFbits.T2IF = 0;
	MOVIA	0xdf
	MOVAR	(_INTFbits + 0)
	.line	553, "main.c"; 	if (s_running == 0U)
	BANKSEL	_s_running
	MOVR	_s_running,W
	BTRSC	STATUS,2
	.line	555, "main.c"; 	return;
	MGOTO	_02181_DS_
	.line	559, "main.c"; 	if ((s_current_entry_mode == (uint8_t)PLAY_MODE_SILENCE) ||
	BANKSEL	_s_current_entry_mode
	MOVR	_s_current_entry_mode,W
	XORIA	0x02
	BTRSC	STATUS,2
	MGOTO	_02147_DS_
	.line	560, "main.c"; 	(s_current_entry_mode == (uint8_t)PLAY_MODE_CONTINUOUS_CARRIER))
	MOVR	_s_current_entry_mode,W
	XORIA	0x01
	BTRSC	STATUS,2
_02147_DS_:
	.line	562, "main.c"; 	return;
	MGOTO	_02181_DS_
	.line	566, "main.c"; 	if (s_prep_inactive_steps != 0U)
	BANKSEL	_s_prep_inactive_steps
	MOVR	_s_prep_inactive_steps,W
	BTRSC	STATUS,2
	MGOTO	_02151_DS_
	.line	568, "main.c"; 	T3CR1 |= C_PWM3_En;
	SFUNR	_T3CR1
	BANKSEL	r0x102A
	MOVAR	r0x102A
	BSR	r0x102A,7
	MOVR	r0x102A,W
	SFUN	_T3CR1
	.line	569, "main.c"; 	s_current_phase = 1U;
	MOVIA	0x01
	BANKSEL	_s_current_phase
	MOVAR	_s_current_phase
	.line	571, "main.c"; 	TMRH = s_prep_tmrh;
	BANKSEL	_s_prep_tmrh
	MOVR	_s_prep_tmrh,W
	MOVAR	_TMRH
	.line	572, "main.c"; 	TMR2 = s_prep_tmr2;
	BANKSEL	_s_prep_tmr2
	MOVR	_s_prep_tmr2,W
	SFUN	_TMR2
	.line	574, "main.c"; 	s_queued_phase = 0U;
	BANKSEL	_s_queued_phase
	CLRR	_s_queued_phase
	.line	575, "main.c"; 	s_has_queued_chunk = 1U;
	MOVIA	0x01
	BANKSEL	_s_has_queued_chunk
	MOVAR	_s_has_queued_chunk
	.line	576, "main.c"; 	s_prep_inactive_steps = 0U;
	BANKSEL	_s_prep_inactive_steps
	CLRR	_s_prep_inactive_steps
	.line	577, "main.c"; 	return;
	MGOTO	_02181_DS_
_02151_DS_:
	.line	581, "main.c"; 	if (s_has_queued_chunk == 0U)
	BANKSEL	_s_has_queued_chunk
	MOVR	_s_has_queued_chunk,W
	BTRSS	STATUS,2
	MGOTO	_02155_DS_
	.line	583, "main.c"; 	T3CR1 &= (uint8_t)~C_PWM3_En;
	SFUNR	_T3CR1
	BANKSEL	r0x102A
	MOVAR	r0x102A
	BCR	r0x102A,7
	MOVR	r0x102A,W
	SFUN	_T3CR1
	.line	584, "main.c"; 	PORTA = (PIN_MASK_PA7_GREEN_LED | PIN_MASK_PA5_RED_LED | PIN_MASK_PA0_POWER_HOLD);
	MOVIA	0xa1
	MOVAR	_PORTA
	.line	585, "main.c"; 	T2CR1 = C_TMR2_Dis;
	CLRA	
	SFUN	_T2CR1
	.line	586, "main.c"; 	INTFbits.T2IF = 0;
	MOVIA	0xdf
	MOVAR	(_INTFbits + 0)
	.line	587, "main.c"; 	s_prep_inactive_steps = 0U;
	BANKSEL	_s_prep_inactive_steps
	CLRR	_s_prep_inactive_steps
	.line	589, "main.c"; 	if (s_current_entry_mode == (uint8_t)PLAY_MODE_ONESHOT_MODEL)
	BANKSEL	_s_current_entry_mode
	MOVR	_s_current_entry_mode,W
	XORIA	0x04
	BTRSS	STATUS,2
	MGOTO	_02153_DS_
	.line	591, "main.c"; 	s_entry_expired = 1U;
	MOVIA	0x01
	BANKSEL	_s_entry_expired
	MOVAR	_s_entry_expired
_02153_DS_:
	.line	593, "main.c"; 	return;
	MGOTO	_02181_DS_
_02155_DS_:
	.line	597, "main.c"; 	if (s_current_phase != s_queued_phase)
	BANKSEL	_s_queued_phase
	MOVR	_s_queued_phase,W
	BANKSEL	_s_current_phase
	XORAR	_s_current_phase,W
	BTRSC	STATUS,2
	MGOTO	_02160_DS_
	.line	599, "main.c"; 	s_current_phase = s_queued_phase;
	BANKSEL	_s_queued_phase
	MOVR	_s_queued_phase,W
	BANKSEL	_s_current_phase
	MOVAR	_s_current_phase
	.line	600, "main.c"; 	if (s_current_phase != 0U)
	BTRSC	STATUS,2
	MGOTO	_02157_DS_
	.line	602, "main.c"; 	T3CR1 |= C_PWM3_En;
	SFUNR	_T3CR1
	BANKSEL	r0x102A
	MOVAR	r0x102A
	BSR	r0x102A,7
	MOVR	r0x102A,W
	SFUN	_T3CR1
	MGOTO	_02160_DS_
_02157_DS_:
	.line	606, "main.c"; 	T3CR1 &= (uint8_t)~C_PWM3_En;
	SFUNR	_T3CR1
	BANKSEL	r0x102A
	MOVAR	r0x102A
	BCR	r0x102A,7
	MOVR	r0x102A,W
	SFUN	_T3CR1
	.line	607, "main.c"; 	PORTA = (PIN_MASK_PA7_GREEN_LED | PIN_MASK_PA5_RED_LED | PIN_MASK_PA0_POWER_HOLD);
	MOVIA	0xa1
	MOVAR	_PORTA
_02160_DS_:
	.line	612, "main.c"; 	encoded = determine_next_chunk();
	MCALL	_determine_next_chunk
	BANKSEL	r0x102A
	MOVAR	r0x102A
	.line	613, "main.c"; 	if (encoded == 0U)
	MOVR	r0x102A,W
	BTRSS	STATUS,2
	MGOTO	_02166_DS_
	.line	616, "main.c"; 	select_result = select_next_stage(&standard_stage_index);
	MOVIA	(_service_timer2_underflow_standard_stage_index_65536_83 + 0)
	BANKSEL	r0x102B
	MOVAR	r0x102B
	BANKSEL	r0x102C
	CLRR	r0x102C
	BANKSEL	r0x102D
	CLRR	r0x102D
	BANKSEL	r0x102B
	MOVR	r0x102B,W
	MOVAR	STK01
	MOVIA	0x00
	MOVAR	STK00
	MCALL	_select_next_stage
	BANKSEL	r0x102B
	MOVAR	r0x102B
	.line	617, "main.c"; 	if (select_result == STAGE_SELECT_STANDARD)
	XORIA	0x02
	BTRSS	STATUS,2
	MGOTO	_02162_DS_
	.line	619, "main.c"; 	waveform_model_load_stage(s_current_model_id, standard_stage_index);
	BANKSEL	_service_timer2_underflow_standard_stage_index_65536_83
	MOVR	_service_timer2_underflow_standard_stage_index_65536_83,W
	MOVAR	STK00
	BANKSEL	_s_current_model_id
	MOVR	_s_current_model_id,W
	MCALL	_waveform_model_load_stage
	.line	620, "main.c"; 	s_active_rem = g_stage_on_steps;
	BANKSEL	_g_stage_on_steps
	MOVR	_g_stage_on_steps,W
	BANKSEL	_s_active_rem
	MOVAR	_s_active_rem
	BANKSEL	_g_stage_on_steps
	MOVR	(_g_stage_on_steps + 1),W
	BANKSEL	_s_active_rem
	MOVAR	(_s_active_rem + 1)
	.line	621, "main.c"; 	s_inactive_rem = g_stage_off_steps;
	BANKSEL	_g_stage_off_steps
	MOVR	_g_stage_off_steps,W
	BANKSEL	_s_inactive_rem
	MOVAR	_s_inactive_rem
	BANKSEL	_g_stage_off_steps
	MOVR	(_g_stage_off_steps + 1),W
	BANKSEL	_s_inactive_rem
	MOVAR	(_s_inactive_rem + 1)
	.line	622, "main.c"; 	select_result = STAGE_SELECT_READY;
	MOVIA	0x01
	BANKSEL	r0x102B
	MOVAR	r0x102B
_02162_DS_:
	.line	624, "main.c"; 	if (select_result == STAGE_SELECT_READY)
	BANKSEL	r0x102B
	MOVR	r0x102B,W
	XORIA	0x01
	BTRSS	STATUS,2
	MGOTO	_02166_DS_
	.line	626, "main.c"; 	encoded = determine_next_chunk();
	MCALL	_determine_next_chunk
	BANKSEL	r0x102A
	MOVAR	r0x102A
_02166_DS_:
	.line	630, "main.c"; 	if (encoded > 0U)
	BANKSEL	r0x102A
	MOVR	r0x102A,W
	BTRSC	STATUS,2
	MGOTO	_02179_DS_
	.line	632, "main.c"; 	next_phase = (encoded & 0x80U) != 0U;
	MOVIA	0x80
	ANDAR	r0x102A,W
	BANKSEL	r0x102B
	MOVAR	r0x102B
	MOVR	r0x102B,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x102C
	MOVAR	r0x102C
	MOVR	r0x102C,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x102B
	MOVAR	r0x102B
	BANKSEL	r0x102C
	CLRR	r0x102C
	BANKSEL	r0x102B
	BTRSS	r0x102B,0
	MGOTO	_00001_DS_
	BANKSEL	r0x102C
	INCR	r0x102C,F
_00001_DS_:
	.line	633, "main.c"; 	next_chunk = encoded & 0x3FU;
	MOVIA	0x3f
	BANKSEL	r0x102A
	ANDAR	r0x102A,F
	.line	635, "main.c"; 	if ((next_phase != 0U) && (next_chunk == 2U))
	BANKSEL	r0x102C
	MOVR	r0x102C,W
	BTRSC	STATUS,2
	MGOTO	_02175_DS_
	BANKSEL	r0x102A
	MOVR	r0x102A,W
	XORIA	0x02
	BTRSS	STATUS,2
	MGOTO	_02175_DS_
	.line	637, "main.c"; 	if (s_inactive_rem > 0U)
	BANKSEL	_s_inactive_rem
	MOVR	(_s_inactive_rem + 1),W
	IORAR	_s_inactive_rem,W
	BTRSC	STATUS,2
	MGOTO	_02172_DS_
	.line	639, "main.c"; 	prep_encoded = determine_next_chunk();
	MCALL	_determine_next_chunk
	BANKSEL	r0x102B
	MOVAR	r0x102B
	.line	640, "main.c"; 	prep_steps = prep_encoded & 0x3FU;
	MOVIA	0x3f
	ANDAR	r0x102B,F
	.line	641, "main.c"; 	reload = (uint16_t)(((uint16_t)prep_steps << 4) + ((uint16_t)prep_steps << 2) - 1U);
	MOVR	r0x102B,W
	BANKSEL	r0x102D
	MOVAR	r0x102D
	BANKSEL	r0x102E
	CLRR	r0x102E
	SWAPR	r0x102E,W
	ANDIA	0xf0
	BANKSEL	r0x102F
	MOVAR	r0x102F
	BANKSEL	r0x102D
	SWAPR	r0x102D,W
	BANKSEL	r0x1030
	MOVAR	r0x1030
	ANDIA	0x0f
	BANKSEL	r0x102F
	IORAR	r0x102F,F
	BANKSEL	r0x1030
	XORAR	r0x1030,F
	BCR	STATUS,0
	BANKSEL	r0x102D
	RLR	r0x102D,F
	BANKSEL	r0x102E
	RLR	r0x102E,F
	BCR	STATUS,0
	BANKSEL	r0x102D
	RLR	r0x102D,F
	BANKSEL	r0x102E
	RLR	r0x102E,F
	BANKSEL	r0x102D
	MOVR	r0x102D,W
	BANKSEL	r0x1030
	ADDAR	r0x1030,F
	BANKSEL	r0x102E
	MOVR	r0x102E,W
	BANKSEL	r0x102F
	ADCAR	r0x102F,F
	MOVIA	0xff
	BANKSEL	r0x1030
	ADDAR	r0x1030,F
	MOVIA	0xff
	BANKSEL	r0x102F
	ADCAR	r0x102F,F
	.line	642, "main.c"; 	tmrh_val = 0U;
	BANKSEL	r0x102D
	CLRR	r0x102D
	.line	644, "main.c"; 	if ((reload & 0x0200U) != 0U)
	BANKSEL	r0x102F
	BTRSS	r0x102F,1
	MGOTO	_02168_DS_
	.line	646, "main.c"; 	tmrh_val |= C_TMR2_Data_b9;
	MOVIA	0x80
	BANKSEL	r0x102D
	MOVAR	r0x102D
_02168_DS_:
	.line	648, "main.c"; 	if ((reload & 0x0100U) != 0U)
	BANKSEL	r0x102F
	BTRSS	r0x102F,0
	MGOTO	_02170_DS_
	.line	650, "main.c"; 	tmrh_val |= C_TMR2_Data_b8;
	BANKSEL	r0x102D
	BSR	r0x102D,6
_02170_DS_:
	.line	653, "main.c"; 	s_prep_tmrh = tmrh_val;
	BANKSEL	r0x102D
	MOVR	r0x102D,W
	BANKSEL	_s_prep_tmrh
	MOVAR	_s_prep_tmrh
	.line	654, "main.c"; 	s_prep_tmr2 = (uint8_t)reload;
	BANKSEL	r0x1030
	MOVR	r0x1030,W
	BANKSEL	_s_prep_tmr2
	MOVAR	_s_prep_tmr2
	.line	655, "main.c"; 	s_prep_inactive_steps = prep_steps;
	BANKSEL	r0x102B
	MOVR	r0x102B,W
	BANKSEL	_s_prep_inactive_steps
	MOVAR	_s_prep_inactive_steps
	MGOTO	_02173_DS_
_02172_DS_:
	.line	659, "main.c"; 	s_prep_inactive_steps = 0U;
	BANKSEL	_s_prep_inactive_steps
	CLRR	_s_prep_inactive_steps
_02173_DS_:
	.line	662, "main.c"; 	s_queued_phase = 1U;
	MOVIA	0x01
	BANKSEL	_s_queued_phase
	MOVAR	_s_queued_phase
	.line	663, "main.c"; 	s_has_queued_chunk = 1U;
	BANKSEL	_s_has_queued_chunk
	MOVAR	_s_has_queued_chunk
	.line	664, "main.c"; 	timer2_queue_interval(2U);
	MOVIA	0x02
	MCALL	_timer2_queue_interval
	MGOTO	_02181_DS_
_02175_DS_:
	.line	668, "main.c"; 	s_queued_phase = next_phase;
	BANKSEL	r0x102C
	MOVR	r0x102C,W
	BANKSEL	_s_queued_phase
	MOVAR	_s_queued_phase
	.line	669, "main.c"; 	s_has_queued_chunk = 1U;
	MOVIA	0x01
	BANKSEL	_s_has_queued_chunk
	MOVAR	_s_has_queued_chunk
	.line	670, "main.c"; 	timer2_queue_interval(next_chunk);
	BANKSEL	r0x102A
	MOVR	r0x102A,W
	MCALL	_timer2_queue_interval
	MGOTO	_02181_DS_
_02179_DS_:
	.line	675, "main.c"; 	s_has_queued_chunk = 0U;
	BANKSEL	_s_has_queued_chunk
	CLRR	_s_has_queued_chunk
	.line	676, "main.c"; 	s_prep_inactive_steps = 0U;
	BANKSEL	_s_prep_inactive_steps
	CLRR	_s_prep_inactive_steps
_02181_DS_:
	.line	678, "main.c"; 	}
	RETURN	
; exit point of _service_timer2_underflow

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrget1
;   __gptrget1
;   __gptrget1
;   _pwm3_set_enabled
;   _pwm3_set_enabled
;   _select_next_stage
;   _waveform_model_load_stage
;   _determine_next_chunk
;   _pwm3_set_enabled
;   _timer2_queue_interval
;   _determine_next_chunk
;   _select_next_stage
;   _waveform_model_load_stage
;   _determine_next_chunk
;   _timer2_queue_interval
;   __gptrget1
;   __gptrget1
;   __gptrget1
;   _pwm3_set_enabled
;   _pwm3_set_enabled
;   _select_next_stage
;   _waveform_model_load_stage
;   _determine_next_chunk
;   _pwm3_set_enabled
;   _timer2_queue_interval
;   _determine_next_chunk
;   _select_next_stage
;   _waveform_model_load_stage
;   _determine_next_chunk
;   _timer2_queue_interval
;7 compiler assigned registers:
;   r0x1024
;   r0x1025
;   r0x1026
;   STK01
;   STK00
;   r0x1027
;   r0x1028
;; Starting pCode block
.segment "code"; module=main, function=_load_playlist_entry
	.debuginfo subprogram _load_playlist_entry
;local variable name mapping:
	.debuginfo complex-type (local-sym "_index" 1 "main.c" 386 (basetype 1 unsigned) split "r0x1024")
	.debuginfo complex-type (local-sym "_entry_offset" 1 "main.c" 390 (basetype 1 unsigned) split "r0x1024")
	.debuginfo complex-type (local-sym "_duration_code" 1 "main.c" 391 (basetype 1 unsigned) split "r0x1027")
	.debuginfo complex-type (local-sym "_control" 1 "main.c" 392 (basetype 1 unsigned) split "r0x1028")
	.debuginfo complex-type (local-sym "_mode_code" 1 "main.c" 393 (basetype 1 unsigned) split "r0x1028")
	.debuginfo complex-type (local-sym "_select_result" 1 "main.c" 388 (basetype 1 unsigned) split "r0x1024")
	.debuginfo complex-type (local-sym "_standard_stage_index" 1 "main.c" 389 (basetype 1 unsigned) link "_load_playlist_entry_standard_stage_index_65536_63")
	.debuginfo complex-type (local-sym "_first_encoded" 1 "main.c" 394 (basetype 1 unsigned) split "r0x1024")
	.debuginfo complex-type (local-sym "_first_phase" 1 "main.c" 395 (basetype 1 unsigned) split "r0x1026")
	.debuginfo complex-type (local-sym "_first_chunk" 1 "main.c" 396 (basetype 1 unsigned) split "r0x1024")
	.debuginfo complex-type (local-sym "_queued_encoded" 1 "main.c" 397 (basetype 1 unsigned) split "r0x1024")
	.debuginfo complex-type (local-sym "_queued_chunk" 1 "main.c" 399 (basetype 1 unsigned) split "r0x1024")
_load_playlist_entry:
; 2 exit points
	.line	386, "main.c"; 	static void load_playlist_entry(uint8_t index)
	BANKSEL	r0x1024
	MOVAR	r0x1024
	.line	401, "main.c"; 	entry_offset = (uint8_t)((index << 1) + index);
	BCR	STATUS,0
	RLR	r0x1024,W
;;3	MOVAR	r0x1025
	ADDAR	r0x1024,F
	.line	402, "main.c"; 	duration_code = c_playlist[entry_offset];
	MOVR	r0x1024,W
	ADDIA	(_c_playlist + 0)
	BANKSEL	r0x1025
	MOVAR	r0x1025
	MOVIA	((_c_playlist + 0) >> 8) & 0xff
	ADCIA	0x00
	BANKSEL	r0x1026
	MOVAR	r0x1026
	BANKSEL	r0x1025
	MOVR	r0x1025,W
	MOVAR	STK01
	BANKSEL	r0x1026
	MOVR	r0x1026,W
	MOVAR	STK00
	MOVIA	0x80
	MCALL	__gptrget1
	BANKSEL	r0x1027
	MOVAR	r0x1027
	.line	403, "main.c"; 	control = c_playlist[entry_offset + 1U];
	BANKSEL	r0x1024
	INCR	r0x1024,W
	BANKSEL	r0x1025
	MOVAR	r0x1025
	MOVIA	(_c_playlist + 0)
	ADDAR	r0x1025,F
	MOVIA	((_c_playlist + 0) >> 8) & 0xff
	ADCIA	0x00
	BANKSEL	r0x1026
	MOVAR	r0x1026
	BANKSEL	r0x1025
	MOVR	r0x1025,W
	MOVAR	STK01
	BANKSEL	r0x1026
	MOVR	r0x1026,W
	MOVAR	STK00
	MOVIA	0x80
	MCALL	__gptrget1
	BANKSEL	r0x1028
	MOVAR	r0x1028
	.line	405, "main.c"; 	T2CR1 = C_TMR2_Dis;
	CLRA	
	SFUN	_T2CR1
	.line	406, "main.c"; 	INTFbits.T2IF = 0;
	MOVIA	0xdf
	MOVAR	(_INTFbits + 0)
	.line	407, "main.c"; 	s_active_rem = 0U;
	BANKSEL	_s_active_rem
	CLRR	_s_active_rem
	CLRR	(_s_active_rem + 1)
	.line	408, "main.c"; 	s_inactive_rem = 0U;
	BANKSEL	_s_inactive_rem
	CLRR	_s_inactive_rem
	CLRR	(_s_inactive_rem + 1)
	.line	409, "main.c"; 	s_current_phase = 0U;
	BANKSEL	_s_current_phase
	CLRR	_s_current_phase
	.line	410, "main.c"; 	s_queued_phase = 0U;
	BANKSEL	_s_queued_phase
	CLRR	_s_queued_phase
	.line	411, "main.c"; 	s_has_queued_chunk = 0U;
	BANKSEL	_s_has_queued_chunk
	CLRR	_s_has_queued_chunk
	.line	412, "main.c"; 	s_prep_inactive_steps = 0U;
	BANKSEL	_s_prep_inactive_steps
	CLRR	_s_prep_inactive_steps
	.line	413, "main.c"; 	s_prep_tmrh = 0U;
	BANKSEL	_s_prep_tmrh
	CLRR	_s_prep_tmrh
	.line	414, "main.c"; 	s_prep_tmr2 = 0U;
	BANKSEL	_s_prep_tmr2
	CLRR	_s_prep_tmr2
	.line	415, "main.c"; 	s_current_entry_mode = (uint8_t)PLAY_MODE_SILENCE;
	MOVIA	0x02
	BANKSEL	_s_current_entry_mode
	MOVAR	_s_current_entry_mode
	.line	416, "main.c"; 	s_current_model_id = (uint8_t)(control & PLAYLIST_MODEL_MASK);
	MOVIA	0x1f
	BANKSEL	r0x1028
	ANDAR	r0x1028,W
	BANKSEL	_s_current_model_id
	MOVAR	_s_current_model_id
	.line	417, "main.c"; 	s_current_stage_count = c_playlist[entry_offset + 2U];
	BANKSEL	r0x1024
	INCR	r0x1024,F
	INCR	r0x1024,F
	MOVIA	(_c_playlist + 0)
	ADDAR	r0x1024,F
	MOVIA	((_c_playlist + 0) >> 8) & 0xff
	ADCIA	0x00
	BANKSEL	r0x1025
	MOVAR	r0x1025
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	MOVAR	STK01
	BANKSEL	r0x1025
	MOVR	r0x1025,W
	MOVAR	STK00
	MOVIA	0x80
	MCALL	__gptrget1
	BANKSEL	_s_current_stage_count
	MOVAR	_s_current_stage_count
	.line	418, "main.c"; 	s_stage_index = 0U;
	BANKSEL	_s_stage_index
	CLRR	_s_stage_index
	.line	419, "main.c"; 	s_c10_phase = 0U;
	BANKSEL	_s_c10_phase
	CLRR	_s_c10_phase
	.line	420, "main.c"; 	s_c10_round = 0U;
	BANKSEL	_s_c10_round
	CLRR	_s_c10_round
	.line	421, "main.c"; 	s_c10_stage = 0U;
	BANKSEL	_s_c10_stage
	CLRR	_s_c10_stage
	.line	422, "main.c"; 	pwm3_set_enabled(false);
	MOVIA	0x00
	MCALL	_pwm3_set_enabled
	.line	425, "main.c"; 	s_entry_timer_10ms = (uint16_t)(((uint16_t)duration_code << 4) +
	BANKSEL	r0x1027
	MOVR	r0x1027,W
	BANKSEL	r0x1024
	MOVAR	r0x1024
	BANKSEL	r0x1025
	CLRR	r0x1025
	SWAPR	r0x1025,W
	ANDIA	0xf0
	BANKSEL	r0x1027
	MOVAR	r0x1027
	BANKSEL	r0x1024
	SWAPR	r0x1024,W
	BANKSEL	r0x1026
	MOVAR	r0x1026
	ANDIA	0x0f
	BANKSEL	r0x1027
	IORAR	r0x1027,F
	BANKSEL	r0x1026
	XORAR	r0x1026,F
	.line	426, "main.c"; 	((uint16_t)duration_code << 2));
	BCR	STATUS,0
	BANKSEL	r0x1024
	RLR	r0x1024,F
	BANKSEL	r0x1025
	RLR	r0x1025,F
	BCR	STATUS,0
	BANKSEL	r0x1024
	RLR	r0x1024,F
	BANKSEL	r0x1025
	RLR	r0x1025,F
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	BANKSEL	r0x1026
	ADDAR	r0x1026,W
	BANKSEL	_s_entry_timer_10ms
	MOVAR	_s_entry_timer_10ms
	BANKSEL	r0x1025
	MOVR	r0x1025,W
	BANKSEL	r0x1027
	ADCAR	r0x1027,W
	BANKSEL	_s_entry_timer_10ms
	MOVAR	(_s_entry_timer_10ms + 1)
	.line	428, "main.c"; 	if ((control & PLAYLIST_CP1) != 0U)
	MOVIA	0x20
	BANKSEL	r0x1028
	ANDAR	r0x1028,W
	BANKSEL	r0x1024
	MOVAR	r0x1024
	MOVR	r0x1024,W
	BTRSC	STATUS,2
	MGOTO	_02107_DS_
	.line	430, "main.c"; 	PWM3DUTY = 40U;
	MOVIA	0x28
	SFUN	_PWM3DUTY
	MGOTO	_02108_DS_
_02107_DS_:
	.line	434, "main.c"; 	PWM3DUTY = 25U;
	MOVIA	0x19
	SFUN	_PWM3DUTY
_02108_DS_:
	.line	437, "main.c"; 	mode_code = (uint8_t)(control & PLAYLIST_MODE_MASK);
	MOVIA	0xc0
	BANKSEL	r0x1028
	ANDAR	r0x1028,F
	.line	438, "main.c"; 	if (mode_code == PLAYLIST_MODE_REPEAT)
	MOVR	r0x1028,W
	BTRSS	STATUS,2
	MGOTO	_02119_DS_
	.line	440, "main.c"; 	s_current_entry_mode = (uint8_t)PLAY_MODE_REPEAT_MODEL;
	BANKSEL	_s_current_entry_mode
	CLRR	_s_current_entry_mode
	MGOTO	_02120_DS_
_02119_DS_:
	.line	442, "main.c"; 	else if (mode_code == PLAYLIST_MODE_ONESHOT)
	BANKSEL	r0x1028
	MOVR	r0x1028,W
	XORIA	0x40
	BTRSS	STATUS,2
	MGOTO	_02116_DS_
	.line	444, "main.c"; 	s_current_entry_mode = (uint8_t)PLAY_MODE_ONESHOT_MODEL;
	MOVIA	0x04
	BANKSEL	_s_current_entry_mode
	MOVAR	_s_current_entry_mode
	MGOTO	_02120_DS_
_02116_DS_:
	.line	446, "main.c"; 	else if (mode_code == PLAYLIST_MODE_PASSIVE)
	BANKSEL	r0x1028
	MOVR	r0x1028,W
	XORIA	0x80
	BTRSS	STATUS,2
	MGOTO	_02113_DS_
	.line	448, "main.c"; 	if ((control & PLAYLIST_CP1) != 0U)
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	BTRSC	STATUS,2
	MGOTO	_02110_DS_
	.line	450, "main.c"; 	s_current_entry_mode = (uint8_t)PLAY_MODE_CONTINUOUS_CARRIER;
	MOVIA	0x01
	BANKSEL	_s_current_entry_mode
	MOVAR	_s_current_entry_mode
	MGOTO	_02120_DS_
_02110_DS_:
	.line	454, "main.c"; 	s_current_entry_mode = (uint8_t)PLAY_MODE_SILENCE;
	MOVIA	0x02
	BANKSEL	_s_current_entry_mode
	MOVAR	_s_current_entry_mode
	MGOTO	_02120_DS_
_02113_DS_:
	.line	459, "main.c"; 	s_current_entry_mode = (uint8_t)PLAY_MODE_C10;
	MOVIA	0x03
	BANKSEL	_s_current_entry_mode
	MOVAR	_s_current_entry_mode
_02120_DS_:
	.line	462, "main.c"; 	if (s_current_entry_mode == (uint8_t)PLAY_MODE_CONTINUOUS_CARRIER)
	BANKSEL	_s_current_entry_mode
	MOVR	_s_current_entry_mode,W
	XORIA	0x01
	BTRSS	STATUS,2
	MGOTO	_02122_DS_
	.line	464, "main.c"; 	pwm3_set_enabled(true);
	MOVIA	0x01
	MCALL	_pwm3_set_enabled
	.line	465, "main.c"; 	return;
	MGOTO	_02140_DS_
_02122_DS_:
	.line	468, "main.c"; 	if (s_current_entry_mode == (uint8_t)PLAY_MODE_SILENCE)
	BANKSEL	_s_current_entry_mode
	MOVR	_s_current_entry_mode,W
	XORIA	0x02
	BTRSC	STATUS,2
	.line	470, "main.c"; 	return;
	MGOTO	_02140_DS_
	.line	473, "main.c"; 	select_result = select_next_stage(&standard_stage_index);
	MOVIA	(_load_playlist_entry_standard_stage_index_65536_63 + 0)
	BANKSEL	r0x1024
	MOVAR	r0x1024
	BANKSEL	r0x1025
	CLRR	r0x1025
	BANKSEL	r0x1026
	CLRR	r0x1026
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	MOVAR	STK01
	MOVIA	0x00
	MOVAR	STK00
	MCALL	_select_next_stage
	BANKSEL	r0x1024
	MOVAR	r0x1024
	.line	474, "main.c"; 	if (select_result == STAGE_SELECT_STANDARD)
	XORIA	0x02
	BTRSS	STATUS,2
	MGOTO	_02126_DS_
	.line	476, "main.c"; 	waveform_model_load_stage(s_current_model_id, standard_stage_index);
	BANKSEL	_load_playlist_entry_standard_stage_index_65536_63
	MOVR	_load_playlist_entry_standard_stage_index_65536_63,W
	MOVAR	STK00
	BANKSEL	_s_current_model_id
	MOVR	_s_current_model_id,W
	MCALL	_waveform_model_load_stage
	.line	477, "main.c"; 	s_active_rem = g_stage_on_steps;
	BANKSEL	_g_stage_on_steps
	MOVR	_g_stage_on_steps,W
	BANKSEL	_s_active_rem
	MOVAR	_s_active_rem
	BANKSEL	_g_stage_on_steps
	MOVR	(_g_stage_on_steps + 1),W
	BANKSEL	_s_active_rem
	MOVAR	(_s_active_rem + 1)
	.line	478, "main.c"; 	s_inactive_rem = g_stage_off_steps;
	BANKSEL	_g_stage_off_steps
	MOVR	_g_stage_off_steps,W
	BANKSEL	_s_inactive_rem
	MOVAR	_s_inactive_rem
	BANKSEL	_g_stage_off_steps
	MOVR	(_g_stage_off_steps + 1),W
	BANKSEL	_s_inactive_rem
	MOVAR	(_s_inactive_rem + 1)
	.line	479, "main.c"; 	select_result = STAGE_SELECT_READY;
	MOVIA	0x01
	BANKSEL	r0x1024
	MOVAR	r0x1024
_02126_DS_:
	.line	481, "main.c"; 	if (select_result == STAGE_SELECT_NONE)
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	BTRSC	STATUS,2
	.line	483, "main.c"; 	return;
	MGOTO	_02140_DS_
	.line	486, "main.c"; 	first_encoded = determine_next_chunk();
	MCALL	_determine_next_chunk
	BANKSEL	r0x1024
	MOVAR	r0x1024
	.line	487, "main.c"; 	if (first_encoded == 0U)
	MOVR	r0x1024,W
	BTRSC	STATUS,2
	.line	489, "main.c"; 	return;
	MGOTO	_02140_DS_
	.line	492, "main.c"; 	first_phase = (uint8_t)((first_encoded & 0x80U) != 0U);
	MOVIA	0x80
	ANDAR	r0x1024,W
	BANKSEL	r0x1025
	MOVAR	r0x1025
	MOVR	r0x1025,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1026
	MOVAR	r0x1026
	MOVR	r0x1026,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1025
	MOVAR	r0x1025
	BANKSEL	r0x1026
	CLRR	r0x1026
	BANKSEL	r0x1025
	BTRSS	r0x1025,0
	MGOTO	_00002_DS_
	BANKSEL	r0x1026
	INCR	r0x1026,F
_00002_DS_:
	.line	493, "main.c"; 	first_chunk = (uint8_t)(first_encoded & 0x3FU);
	MOVIA	0x3f
	BANKSEL	r0x1024
	ANDAR	r0x1024,F
	.line	495, "main.c"; 	s_current_phase = first_phase;
	BANKSEL	r0x1026
	MOVR	r0x1026,W
	BANKSEL	_s_current_phase
	MOVAR	_s_current_phase
	.line	496, "main.c"; 	pwm3_set_enabled(first_phase != 0U);
	BANKSEL	r0x1026
	MOVR	r0x1026,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1025
	MOVAR	r0x1025
	MOVR	r0x1025,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1026
	MOVAR	r0x1026
	MCALL	_pwm3_set_enabled
	.line	499, "main.c"; 	timer2_queue_interval(first_chunk);
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	MCALL	_timer2_queue_interval
	.line	500, "main.c"; 	INTFbits.T2IF = 0;
	MOVIA	0xdf
	MOVAR	(_INTFbits + 0)
	.line	501, "main.c"; 	T2CR1 = C_TMR2_Reload | C_TMR2_En;
	MOVIA	0x03
	SFUN	_T2CR1
	.line	503, "main.c"; 	queued_encoded = determine_next_chunk();
	MCALL	_determine_next_chunk
	BANKSEL	r0x1024
	MOVAR	r0x1024
	.line	504, "main.c"; 	if (queued_encoded == 0U)
	MOVR	r0x1024,W
	BTRSS	STATUS,2
	MGOTO	_02136_DS_
	.line	506, "main.c"; 	select_result = select_next_stage(&standard_stage_index);
	MOVIA	(_load_playlist_entry_standard_stage_index_65536_63 + 0)
	BANKSEL	r0x1025
	MOVAR	r0x1025
	BANKSEL	r0x1026
	CLRR	r0x1026
	BANKSEL	r0x1027
	CLRR	r0x1027
	BANKSEL	r0x1025
	MOVR	r0x1025,W
	MOVAR	STK01
	MOVIA	0x00
	MOVAR	STK00
	MCALL	_select_next_stage
	BANKSEL	r0x1025
	MOVAR	r0x1025
	.line	507, "main.c"; 	if (select_result == STAGE_SELECT_STANDARD)
	XORIA	0x02
	BTRSS	STATUS,2
	MGOTO	_02132_DS_
	.line	509, "main.c"; 	waveform_model_load_stage(s_current_model_id, standard_stage_index);
	BANKSEL	_load_playlist_entry_standard_stage_index_65536_63
	MOVR	_load_playlist_entry_standard_stage_index_65536_63,W
	MOVAR	STK00
	BANKSEL	_s_current_model_id
	MOVR	_s_current_model_id,W
	MCALL	_waveform_model_load_stage
	.line	510, "main.c"; 	s_active_rem = g_stage_on_steps;
	BANKSEL	_g_stage_on_steps
	MOVR	_g_stage_on_steps,W
	BANKSEL	_s_active_rem
	MOVAR	_s_active_rem
	BANKSEL	_g_stage_on_steps
	MOVR	(_g_stage_on_steps + 1),W
	BANKSEL	_s_active_rem
	MOVAR	(_s_active_rem + 1)
	.line	511, "main.c"; 	s_inactive_rem = g_stage_off_steps;
	BANKSEL	_g_stage_off_steps
	MOVR	_g_stage_off_steps,W
	BANKSEL	_s_inactive_rem
	MOVAR	_s_inactive_rem
	BANKSEL	_g_stage_off_steps
	MOVR	(_g_stage_off_steps + 1),W
	BANKSEL	_s_inactive_rem
	MOVAR	(_s_inactive_rem + 1)
	.line	512, "main.c"; 	select_result = STAGE_SELECT_READY;
	MOVIA	0x01
	BANKSEL	r0x1025
	MOVAR	r0x1025
_02132_DS_:
	.line	514, "main.c"; 	if (select_result == STAGE_SELECT_READY)
	BANKSEL	r0x1025
	MOVR	r0x1025,W
	XORIA	0x01
	BTRSS	STATUS,2
	MGOTO	_02136_DS_
	.line	516, "main.c"; 	queued_encoded = determine_next_chunk();
	MCALL	_determine_next_chunk
	BANKSEL	r0x1024
	MOVAR	r0x1024
_02136_DS_:
	.line	520, "main.c"; 	if (queued_encoded > 0U)
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	BTRSC	STATUS,2
	MGOTO	_02138_DS_
	.line	522, "main.c"; 	queued_phase = (uint8_t)((queued_encoded & 0x80U) != 0U);
	MOVIA	0x80
	ANDAR	r0x1024,W
	BANKSEL	r0x1025
	MOVAR	r0x1025
	MOVR	r0x1025,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1026
	MOVAR	r0x1026
	MOVR	r0x1026,W
	MOVIA	0x00
	BTRSC	STATUS,2
	MOVIA	0x01
	BANKSEL	r0x1025
	MOVAR	r0x1025
	BANKSEL	_s_queued_phase
	CLRR	_s_queued_phase
	BANKSEL	r0x1025
	BTRSS	r0x1025,0
	MGOTO	_00003_DS_
	BANKSEL	_s_queued_phase
	INCR	_s_queued_phase,F
_00003_DS_:
	.line	523, "main.c"; 	queued_chunk = (uint8_t)(queued_encoded & 0x3FU);
	MOVIA	0x3f
	BANKSEL	r0x1024
	ANDAR	r0x1024,F
	.line	525, "main.c"; 	s_has_queued_chunk = 1U;
	MOVIA	0x01
	BANKSEL	_s_has_queued_chunk
	MOVAR	_s_has_queued_chunk
	.line	526, "main.c"; 	timer2_queue_interval(queued_chunk);
	BANKSEL	r0x1024
	MOVR	r0x1024,W
	MCALL	_timer2_queue_interval
	MGOTO	_02140_DS_
_02138_DS_:
	.line	530, "main.c"; 	s_has_queued_chunk = 0U;
	BANKSEL	_s_has_queued_chunk
	CLRR	_s_has_queued_chunk
_02140_DS_:
	.line	532, "main.c"; 	}
	RETURN	
; exit point of _load_playlist_entry

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;5 compiler assigned registers:
;   r0x101F
;   r0x1020
;   r0x1021
;   r0x1022
;   r0x1023
;; Starting pCode block
.segment "code"; module=main, function=_determine_next_chunk
	.debuginfo subprogram _determine_next_chunk
;local variable name mapping:
	.debuginfo complex-type (local-sym "_rem" 2 "main.c" 340 (basetype 2 unsigned) split "r0x101F" "r0x1020")
	.debuginfo complex-type (local-sym "_chunk" 1 "main.c" 339 (basetype 1 unsigned) split "r0x1021")
_determine_next_chunk:
; 2 exit points
	.line	342, "main.c"; 	if (s_active_rem > 0U)
	BANKSEL	_s_active_rem
	MOVR	(_s_active_rem + 1),W
	IORAR	_s_active_rem,W
	BTRSC	STATUS,2
	MGOTO	_02088_DS_
	.line	344, "main.c"; 	rem = s_active_rem;
	MOVR	_s_active_rem,W
	BANKSEL	r0x101F
	MOVAR	r0x101F
	BANKSEL	_s_active_rem
	MOVR	(_s_active_rem + 1),W
	BANKSEL	r0x1020
	MOVAR	r0x1020
	MGOTO	_02089_DS_
_02088_DS_:
	.line	346, "main.c"; 	else if (s_inactive_rem > 0U)
	BANKSEL	_s_inactive_rem
	MOVR	(_s_inactive_rem + 1),W
	IORAR	_s_inactive_rem,W
	BTRSC	STATUS,2
	MGOTO	_02085_DS_
	.line	348, "main.c"; 	rem = s_inactive_rem;
	MOVR	_s_inactive_rem,W
	BANKSEL	r0x101F
	MOVAR	r0x101F
	BANKSEL	_s_inactive_rem
	MOVR	(_s_inactive_rem + 1),W
	BANKSEL	r0x1020
	MOVAR	r0x1020
	MGOTO	_02089_DS_
_02085_DS_:
	.line	352, "main.c"; 	return 0U;
	MOVIA	0x00
	MGOTO	_02101_DS_
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x33=51), size=2
_02089_DS_:
	.line	355, "main.c"; 	if (rem <= 50U)
	MOVIA	0x33
	BANKSEL	r0x101F
	SUBAR	r0x101F,W
	MOVIA	0x00
	BANKSEL	r0x1020
	SBCAR	r0x1020,W
	BTRSC	STATUS,0
	MGOTO	_02097_DS_
	.line	357, "main.c"; 	chunk = (uint8_t)rem;
	BANKSEL	r0x101F
	MOVR	r0x101F,W
	BANKSEL	r0x1021
	MOVAR	r0x1021
	MGOTO	_02098_DS_
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x4B=75), size=2
_02097_DS_:
	.line	359, "main.c"; 	else if (rem <= 74U)
	MOVIA	0x4b
	BANKSEL	r0x101F
	SUBAR	r0x101F,W
	MOVIA	0x00
	BANKSEL	r0x1020
	SBCAR	r0x1020,W
	BTRSC	STATUS,0
	MGOTO	_02094_DS_
	.line	361, "main.c"; 	chunk = (uint8_t)(rem >> 1);
	BCR	STATUS,0
	RRR	r0x1020,W
	BANKSEL	r0x1022
	MOVAR	r0x1022
	BANKSEL	r0x101F
	RRR	r0x101F,W
	BANKSEL	r0x1023
	MOVAR	r0x1023
	BANKSEL	r0x1021
	MOVAR	r0x1021
	MGOTO	_02098_DS_
;;swapping arguments (AOP_TYPEs 1/2)
;;unsigned compare: left >= lit(0x65=101), size=2
_02094_DS_:
	.line	363, "main.c"; 	else if (rem <= 100U)
	MOVIA	0x65
	BANKSEL	r0x101F
	SUBAR	r0x101F,W
	MOVIA	0x00
	BANKSEL	r0x1020
	SBCAR	r0x1020,W
	BTRSC	STATUS,0
	MGOTO	_02091_DS_
	.line	365, "main.c"; 	chunk = (uint8_t)(rem - 50U);
	BANKSEL	r0x101F
	MOVR	r0x101F,W
	BANKSEL	r0x1023
	MOVAR	r0x1023
	MOVIA	0xce
	ADDAR	r0x1023,W
	BANKSEL	r0x1021
	MOVAR	r0x1021
	MGOTO	_02098_DS_
_02091_DS_:
	.line	369, "main.c"; 	chunk = 50U;
	MOVIA	0x32
	BANKSEL	r0x1021
	MOVAR	r0x1021
_02098_DS_:
	.line	372, "main.c"; 	if (s_active_rem > 0U)
	BANKSEL	_s_active_rem
	MOVR	(_s_active_rem + 1),W
	IORAR	_s_active_rem,W
	BTRSC	STATUS,2
	MGOTO	_02100_DS_
	.line	374, "main.c"; 	s_active_rem -= chunk;
	BANKSEL	r0x1021
	MOVR	r0x1021,W
;;3	MOVAR	r0x101F
	BANKSEL	r0x1020
	CLRR	r0x1020
;;100	MOVR	r0x101F,W
	MOVIA	0x00
	BANKSEL	r0x1022
	MOVAR	r0x1022
;;102	MOVR	r0x1023,W
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	BANKSEL	r0x1023
	MOVAR	r0x1023
	BANKSEL	_s_active_rem
	SUBAR	_s_active_rem,F
	BANKSEL	r0x1022
	MOVR	r0x1022,W
	BANKSEL	_s_active_rem
	SBCAR	(_s_active_rem + 1),F
	.line	375, "main.c"; 	return (uint8_t)(0x80U | chunk);
	MOVIA	0x80
	BANKSEL	r0x1021
	IORAR	r0x1021,W
	BANKSEL	r0x101F
	MOVAR	r0x101F
	MGOTO	_02101_DS_
_02100_DS_:
	.line	378, "main.c"; 	s_inactive_rem -= chunk;
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	BANKSEL	r0x101F
	MOVAR	r0x101F
	BANKSEL	r0x1020
	CLRR	r0x1020
;;99	MOVR	r0x101F,W
	MOVIA	0x00
	BANKSEL	r0x1022
	MOVAR	r0x1022
;;101	MOVR	r0x1023,W
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	BANKSEL	r0x1023
	MOVAR	r0x1023
	BANKSEL	_s_inactive_rem
	SUBAR	_s_inactive_rem,F
	BANKSEL	r0x1022
	MOVR	r0x1022,W
	BANKSEL	_s_inactive_rem
	SBCAR	(_s_inactive_rem + 1),F
	.line	379, "main.c"; 	return chunk;
	BANKSEL	r0x1021
	MOVR	r0x1021,W
_02101_DS_:
	.line	380, "main.c"; 	}
	RETURN	
; exit point of _determine_next_chunk

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrput1
;   __gptrput1
;   _waveform_model_load_c10_stage
;   _waveform_model_load_c10_stage
;   _waveform_model_load_c10_stage
;   __gptrput1
;   __gptrput1
;   _waveform_model_load_c10_stage
;   _waveform_model_load_c10_stage
;   _waveform_model_load_c10_stage
;7 compiler assigned registers:
;   r0x101F
;   STK00
;   r0x1020
;   STK01
;   r0x1021
;   r0x1022
;   STK02
;; Starting pCode block
.segment "code"; module=main, function=_select_next_stage
	.debuginfo subprogram _select_next_stage
;local variable name mapping:
	.debuginfo complex-type (local-sym "_out_standard_stage_index" 3 "main.c" 236 (pointer gptr 3 (basetype 1 unsigned)) split "r0x1021" "r0x1020" "r0x101F")
	.debuginfo complex-type (local-sym "_mode" 1 "main.c" 238 (basetype 1 unsigned) split "r0x1022")
	.debuginfo complex-type (local-sym "_has_next" 1 "main.c" 276 (basetype 1 signed) split "r0x1021")
_select_next_stage:
; 2 exit points
	.line	236, "main.c"; 	static stage_select_result_t select_next_stage(uint8_t *out_standard_stage_index)
	BANKSEL	r0x101F
	MOVAR	r0x101F
	MOVR	STK00,W
	BANKSEL	r0x1020
	MOVAR	r0x1020
	MOVR	STK01,W
	BANKSEL	r0x1021
	MOVAR	r0x1021
	.line	238, "main.c"; 	uint8_t mode = s_current_entry_mode;
	BANKSEL	_s_current_entry_mode
	MOVR	_s_current_entry_mode,W
	BANKSEL	r0x1022
	MOVAR	r0x1022
	.line	240, "main.c"; 	if (mode == (uint8_t)PLAY_MODE_REPEAT_MODEL)
	BTRSS	STATUS,2
	MGOTO	_02052_DS_
	.line	242, "main.c"; 	if (s_current_stage_count == 0U)
	BANKSEL	_s_current_stage_count
	MOVR	_s_current_stage_count,W
	BTRSS	STATUS,2
	MGOTO	_02046_DS_
	.line	244, "main.c"; 	return STAGE_SELECT_NONE;
	MOVIA	0x00
	MGOTO	_02079_DS_
_02046_DS_:
	.line	246, "main.c"; 	if (s_stage_index >= s_current_stage_count)
	BANKSEL	_s_current_stage_count
	MOVR	_s_current_stage_count,W
	BANKSEL	_s_stage_index
	SUBAR	_s_stage_index,W
	BTRSC	STATUS,0
	.line	248, "main.c"; 	s_stage_index = 0U;
	CLRR	_s_stage_index
	.line	251, "main.c"; 	*out_standard_stage_index = s_stage_index;
	MOVR	_s_stage_index,W
	MOVAR	STK02
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	MOVAR	STK01
	BANKSEL	r0x1020
	MOVR	r0x1020,W
	MOVAR	STK00
	BANKSEL	r0x101F
	MOVR	r0x101F,W
	MCALL	__gptrput1
	.line	252, "main.c"; 	s_stage_index++;
	BANKSEL	_s_stage_index
	INCR	_s_stage_index,F
	.line	253, "main.c"; 	if (s_stage_index >= s_current_stage_count)
	BANKSEL	_s_current_stage_count
	MOVR	_s_current_stage_count,W
	BANKSEL	_s_stage_index
	SUBAR	_s_stage_index,W
	BTRSC	STATUS,0
	.line	255, "main.c"; 	s_stage_index = 0U;
	CLRR	_s_stage_index
	.line	257, "main.c"; 	return STAGE_SELECT_STANDARD;
	MOVIA	0x02
	MGOTO	_02079_DS_
_02052_DS_:
	.line	260, "main.c"; 	if (mode == (uint8_t)PLAY_MODE_ONESHOT_MODEL)
	BANKSEL	r0x1022
	MOVR	r0x1022,W
	XORIA	0x04
	BTRSS	STATUS,2
	MGOTO	_02057_DS_
	.line	262, "main.c"; 	if (s_stage_index < s_current_stage_count)
	BANKSEL	_s_current_stage_count
	MOVR	_s_current_stage_count,W
	BANKSEL	_s_stage_index
	SUBAR	_s_stage_index,W
	BTRSC	STATUS,0
	MGOTO	_02054_DS_
	.line	264, "main.c"; 	*out_standard_stage_index = s_stage_index;
	MOVR	_s_stage_index,W
	MOVAR	STK02
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	MOVAR	STK01
	BANKSEL	r0x1020
	MOVR	r0x1020,W
	MOVAR	STK00
	BANKSEL	r0x101F
	MOVR	r0x101F,W
	MCALL	__gptrput1
	.line	265, "main.c"; 	s_stage_index++;
	BANKSEL	_s_stage_index
	INCR	_s_stage_index,F
	.line	266, "main.c"; 	return STAGE_SELECT_STANDARD;
	MOVIA	0x02
	MGOTO	_02079_DS_
_02054_DS_:
	.line	270, "main.c"; 	return STAGE_SELECT_NONE;
	MOVIA	0x00
	MGOTO	_02079_DS_
_02057_DS_:
	.line	274, "main.c"; 	if (mode == (uint8_t)PLAY_MODE_C10)
	BANKSEL	r0x1022
	MOVR	r0x1022,W
	XORIA	0x03
	BTRSS	STATUS,2
	MGOTO	_02078_DS_
	.line	276, "main.c"; 	bool has_next = false;
	BANKSEL	r0x1021
	CLRR	r0x1021
	.line	278, "main.c"; 	if (s_c10_phase == 0U)
	BANKSEL	_s_c10_phase
	MOVR	_s_c10_phase,W
	BTRSS	STATUS,2
	MGOTO	_02072_DS_
	.line	281, "main.c"; 	has_next = waveform_model_load_c10_stage(0U, s_c10_stage);
	BANKSEL	_s_c10_stage
	MOVR	_s_c10_stage,W
	MOVAR	STK00
	MOVIA	0x00
	MCALL	_waveform_model_load_c10_stage
	BANKSEL	r0x1021
	MOVAR	r0x1021
	.line	282, "main.c"; 	s_c10_stage++;
	BANKSEL	_s_c10_stage
	INCR	_s_c10_stage,F
;;unsigned compare: left < lit(0x1A=26), size=1
	.line	283, "main.c"; 	if (s_c10_stage >= 26U)
	MOVIA	0x1a
	SUBAR	_s_c10_stage,W
	BTRSS	STATUS,0
	MGOTO	_02073_DS_
	.line	285, "main.c"; 	s_c10_stage = 0U;
	CLRR	_s_c10_stage
	.line	286, "main.c"; 	s_c10_round++;
	BANKSEL	_s_c10_round
	INCR	_s_c10_round,F
;;unsigned compare: left < lit(0x9=9), size=1
	.line	287, "main.c"; 	if (s_c10_round >= 9U)
	MOVIA	0x09
	SUBAR	_s_c10_round,W
	BTRSS	STATUS,0
	MGOTO	_02073_DS_
	.line	289, "main.c"; 	s_c10_phase = 1U; /* Transition to Tail */
	MOVIA	0x01
	BANKSEL	_s_c10_phase
	MOVAR	_s_c10_phase
	MGOTO	_02073_DS_
_02072_DS_:
	.line	293, "main.c"; 	else if (s_c10_phase == 1U)
	BANKSEL	_s_c10_phase
	MOVR	_s_c10_phase,W
	XORIA	0x01
	BTRSS	STATUS,2
	MGOTO	_02069_DS_
	.line	296, "main.c"; 	has_next = waveform_model_load_c10_stage(1U, s_c10_stage);
	BANKSEL	_s_c10_stage
	MOVR	_s_c10_stage,W
	MOVAR	STK00
	MOVIA	0x01
	MCALL	_waveform_model_load_c10_stage
	BANKSEL	r0x1021
	MOVAR	r0x1021
	.line	297, "main.c"; 	s_c10_stage++;
	BANKSEL	_s_c10_stage
	INCR	_s_c10_stage,F
;;unsigned compare: left < lit(0xE=14), size=1
	.line	298, "main.c"; 	if (s_c10_stage >= 14U)
	MOVIA	0x0e
	SUBAR	_s_c10_stage,W
	BTRSS	STATUS,0
	MGOTO	_02073_DS_
	.line	300, "main.c"; 	s_c10_phase = 2U; /* Transition to Special Events */
	MOVIA	0x02
	BANKSEL	_s_c10_phase
	MOVAR	_s_c10_phase
	.line	301, "main.c"; 	s_c10_stage = 0U;
	BANKSEL	_s_c10_stage
	CLRR	_s_c10_stage
	MGOTO	_02073_DS_
_02069_DS_:
	.line	304, "main.c"; 	else if (s_c10_phase == 2U)
	BANKSEL	_s_c10_phase
	MOVR	_s_c10_phase,W
	XORIA	0x02
	BTRSS	STATUS,2
	MGOTO	_02073_DS_
	.line	307, "main.c"; 	has_next = waveform_model_load_c10_stage(2U, s_c10_stage);
	BANKSEL	_s_c10_stage
	MOVR	_s_c10_stage,W
	MOVAR	STK00
	MOVIA	0x02
	MCALL	_waveform_model_load_c10_stage
	BANKSEL	r0x1021
	MOVAR	r0x1021
	.line	308, "main.c"; 	s_c10_stage++;
	BANKSEL	_s_c10_stage
	INCR	_s_c10_stage,F
;;unsigned compare: left < lit(0x7=7), size=1
	.line	309, "main.c"; 	if (s_c10_stage >= 7U)
	MOVIA	0x07
	SUBAR	_s_c10_stage,W
	BTRSS	STATUS,0
	MGOTO	_02073_DS_
	.line	311, "main.c"; 	s_c10_phase = 3U; /* Sequence complete */
	MOVIA	0x03
	BANKSEL	_s_c10_phase
	MOVAR	_s_c10_phase
_02073_DS_:
	.line	315, "main.c"; 	if (has_next)
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	BTRSC	STATUS,2
	MGOTO	_02075_DS_
	.line	317, "main.c"; 	s_active_rem = g_stage_on_steps;
	BANKSEL	_g_stage_on_steps
	MOVR	_g_stage_on_steps,W
	BANKSEL	_s_active_rem
	MOVAR	_s_active_rem
	BANKSEL	_g_stage_on_steps
	MOVR	(_g_stage_on_steps + 1),W
	BANKSEL	_s_active_rem
	MOVAR	(_s_active_rem + 1)
	.line	318, "main.c"; 	s_inactive_rem = g_stage_off_steps;
	BANKSEL	_g_stage_off_steps
	MOVR	_g_stage_off_steps,W
	BANKSEL	_s_inactive_rem
	MOVAR	_s_inactive_rem
	BANKSEL	_g_stage_off_steps
	MOVR	(_g_stage_off_steps + 1),W
	BANKSEL	_s_inactive_rem
	MOVAR	(_s_inactive_rem + 1)
	.line	319, "main.c"; 	return STAGE_SELECT_READY;
	MOVIA	0x01
	MGOTO	_02079_DS_
_02075_DS_:
	.line	323, "main.c"; 	return STAGE_SELECT_NONE;
	MOVIA	0x00
	MGOTO	_02079_DS_
_02078_DS_:
	.line	327, "main.c"; 	return STAGE_SELECT_NONE;
	MOVIA	0x00
_02079_DS_:
	.line	328, "main.c"; 	}
	RETURN	
; exit point of _select_next_stage

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;4 compiler assigned registers:
;   r0x101F
;   r0x1020
;   r0x1021
;   r0x1022
;; Starting pCode block
.segment "code"; module=main, function=_timer2_queue_interval
	.debuginfo subprogram _timer2_queue_interval
;local variable name mapping:
	.debuginfo complex-type (local-sym "_steps" 1 "main.c" 212 (basetype 1 unsigned) split "r0x101F")
	.debuginfo complex-type (local-sym "_reload" 2 "main.c" 214 (basetype 2 unsigned) split "r0x101F" "r0x1022")
	.debuginfo complex-type (local-sym "_tmrh_val" 1 "main.c" 215 (basetype 1 unsigned) split "r0x1020")
_timer2_queue_interval:
; 2 exit points
;;3	MOVAR	r0x101F
	.line	214, "main.c"; 	uint16_t reload = (uint16_t)(((uint16_t)steps << 4) + ((uint16_t)steps << 2) - 1U);
	BANKSEL	r0x1020
	MOVAR	r0x1020
	BANKSEL	r0x1021
	CLRR	r0x1021
	SWAPR	r0x1021,W
	ANDIA	0xf0
	BANKSEL	r0x1022
	MOVAR	r0x1022
	BANKSEL	r0x1020
	SWAPR	r0x1020,W
	BANKSEL	r0x101F
	MOVAR	r0x101F
	ANDIA	0x0f
	BANKSEL	r0x1022
	IORAR	r0x1022,F
	BANKSEL	r0x101F
	XORAR	r0x101F,F
	BCR	STATUS,0
	BANKSEL	r0x1020
	RLR	r0x1020,F
	BANKSEL	r0x1021
	RLR	r0x1021,F
	BCR	STATUS,0
	BANKSEL	r0x1020
	RLR	r0x1020,F
	BANKSEL	r0x1021
	RLR	r0x1021,F
	BANKSEL	r0x1020
	MOVR	r0x1020,W
	BANKSEL	r0x101F
	ADDAR	r0x101F,F
	BANKSEL	r0x1021
	MOVR	r0x1021,W
	BANKSEL	r0x1022
	ADCAR	r0x1022,F
	MOVIA	0xff
	BANKSEL	r0x101F
	ADDAR	r0x101F,F
	MOVIA	0xff
	BANKSEL	r0x1022
	ADCAR	r0x1022,F
	.line	215, "main.c"; 	uint8_t tmrh_val = 0U;
	BANKSEL	r0x1020
	CLRR	r0x1020
	.line	217, "main.c"; 	if ((reload & 0x0200U) != 0U)
	BANKSEL	r0x1022
	BTRSS	r0x1022,1
	MGOTO	_02038_DS_
	.line	219, "main.c"; 	tmrh_val |= C_TMR2_Data_b9;
	MOVIA	0x80
	BANKSEL	r0x1020
	MOVAR	r0x1020
_02038_DS_:
	.line	221, "main.c"; 	if ((reload & 0x0100U) != 0U)
	BANKSEL	r0x1022
	BTRSS	r0x1022,0
	MGOTO	_02040_DS_
	.line	223, "main.c"; 	tmrh_val |= C_TMR2_Data_b8;
	BANKSEL	r0x1020
	BSR	r0x1020,6
_02040_DS_:
	.line	226, "main.c"; 	TMRH = tmrh_val;
	BANKSEL	r0x1020
	MOVR	r0x1020,W
	MOVAR	_TMRH
	.line	227, "main.c"; 	TMR2 = (uint8_t)reload;
	BANKSEL	r0x101F
	MOVR	r0x101F,W
	BANKSEL	r0x1020
	MOVAR	r0x1020
	SFUN	_TMR2
	.line	228, "main.c"; 	}
	RETURN	
; exit point of _timer2_queue_interval

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;1 compiler assigned register :
;   r0x101F
;; Starting pCode block
.segment "code"; module=main, function=_pwm3_set_enabled
	.debuginfo subprogram _pwm3_set_enabled
;local variable name mapping:
	.debuginfo complex-type (local-sym "_enabled" 1 "main.c" 158 (basetype 1 signed) split "r0x101F")
_pwm3_set_enabled:
; 2 exit points
	.line	158, "main.c"; 	static void pwm3_set_enabled(bool enabled)
	BANKSEL	r0x101F
	MOVAR	r0x101F
	.line	160, "main.c"; 	if (enabled)
	MOVR	r0x101F,W
	BTRSC	STATUS,2
	MGOTO	_02018_DS_
	.line	162, "main.c"; 	T3CR1 |= C_PWM3_En;
	SFUNR	_T3CR1
	MOVAR	r0x101F
	BSR	r0x101F,7
	MOVR	r0x101F,W
	SFUN	_T3CR1
	MGOTO	_02020_DS_
_02018_DS_:
	.line	166, "main.c"; 	T3CR1 &= (uint8_t)~C_PWM3_En;
	SFUNR	_T3CR1
	BANKSEL	r0x101F
	MOVAR	r0x101F
	BCR	r0x101F,7
	MOVR	r0x101F,W
	SFUN	_T3CR1
	.line	167, "main.c"; 	PORTA = (PIN_MASK_PA7_GREEN_LED | PIN_MASK_PA5_RED_LED | PIN_MASK_PA0_POWER_HOLD);
	MOVIA	0xa1
	MOVAR	_PORTA
_02020_DS_:
	.line	169, "main.c"; 	}
	RETURN	
; exit point of _pwm3_set_enabled


;	code size estimation:
;	  908+  361 =  1269 instructions ( 3260 byte)

	end
