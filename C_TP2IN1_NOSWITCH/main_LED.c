/* =========================================================================
 * Project:		PWM1~PWM4 output at the same time
 * File:		main.c
 * Author:		Ranley
 * Version:		v1.1
 * Date:		2022/11/02
 * Description:
 *	1. Set system clock(SYSCLK) frequency = 20MHz/4T = 5MHz.
 *	2. PWM4(PA3/PA7): Period = 4.88KHz (Duty: 512/1024)
 *	   PWM3(PA2)    : Period = 4.88KHz (Duty: 768/1024)
 *	   PWM2(PA4/PB2): Period = 4.88KHz (Duty: 1023/1024)
 *	   PWM1(PB3)    : Period = 4.88KHz (Duty: 1/1024)
 =========================================================================*/
//--------------- FILE INCLUDE ---------------------------------------------
#include <ny8.h>
#include "ny8_constant.h"

//--------------- GLOBAL DEFINITION ----------------------------------------
#define UPDATE_REG(x)	__asm__("MOVR _" #x ",F")

// System control flags and counters
#define ADC_THRESHOLD_GM 2723 // 2.099V threshold, 12-bit ADC, 3V reference
#define ADC_THRESHOLD_FORD 2700 // 2.129V
unsigned int ADC_threshold=ADC_THRESHOLD_GM;unsigned char system_on=0;// System working flag, 1 if system is active, 0 if idle  
unsigned int green_led_count = 0;// Counter for green LED blinking 
unsigned int red_led_count = 0;// Counter for red LED blinking   
unsigned char adc_counter = 0;// Counter for ADC sampling intervals  
unsigned int timer_count = 0;// Power-off timeout counter
unsigned char red_blink_enable = 0; // Red LED blink enable flag (1 if voltage < 2.5V (enable red LED blink))
unsigned int adc_value = 0;      // Power supply voltage ADC sampling value (12-bit) 


unsigned char R_ADC_DATA_HB;        // High byte of ADC data
unsigned char R_ADC_DATA_LB;        // Low byte of ADC data (lower 4 bits
unsigned char KeyResult = 0;		// Store the scan key result
unsigned char TMR0RELOAD = 256 - 125;
unsigned char FORD_flag = 0;

unsigned int green_led_count_Reload = 0;

#define baseCycles 1
// Base waveform period: 8 microseconds (us)
#define BASE_PERIOD 8 
// Total base cycles in a major cycle =》 204*16 * 8us
#define TOTAL_CYCLES 204
// High-level duration within a major cycle (1872 * 8us ≈ 15ms) = 234*8 * 8us = 117*16 * 8us
#define HIGH_CYCLES 117
// Low-level duration: Total - High (automatically calculated)
#define LOW_CYCLES (TOTAL_CYCLES - HIGH_CYCLES) 
// Array defining sub-cycle durations (in base periods) 
const unsigned char sub_cycles[] = {
	baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles,
	baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles*3, baseCycles, baseCycles*2,
	baseCycles*2, baseCycles, baseCycles, baseCycles*2, baseCycles, baseCycles*2, baseCycles*2, baseCycles, baseCycles*2, baseCycles,
	baseCycles*2, baseCycles*2, baseCycles*2, baseCycles*2, baseCycles*2, baseCycles, baseCycles, baseCycles*2, baseCycles*2, baseCycles*2, baseCycles*2
};

const unsigned char sub_cycles_low[] = {
	baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles,
	baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles, baseCycles*3, baseCycles, baseCycles*2,
	baseCycles*2, baseCycles, baseCycles*2, baseCycles*2, baseCycles, baseCycles*2, baseCycles, baseCycles*2, baseCycles*2, baseCycles,
	baseCycles*2, baseCycles*2, baseCycles*2, baseCycles*2, baseCycles*2, baseCycles, baseCycles, baseCycles*2, baseCycles*2, baseCycles*2, baseCycles*2
};

// Calculate the number of sub-cycles dynamically  
#define SUB_CYCLE_COUNT (sizeof(sub_cycles)/sizeof(sub_cycles[0]))

// Major and minor cycle counters   
unsigned int main_cycle_counter = 0; // Tracks position in major cycle   
unsigned int sub_cycle_index = 0;    // Current sub-cycle index  
unsigned int sub_cycle_counter =0;   // Position within current sub-cycle 
unsigned char output_state = 0;      // PWM output state (1=high, 0=low)


//--------------- FUNCTION PROTOTYPES --------------------------------------
void GPIO_init(void);
void PWM3_GM(void);
void PWM3_FORD(void);
void ADC_init(void);
void Delay(unsigned int count);
void TIM0_Init(void);
void TIM1_Init(void);
void TIM2_Init(void);
void INTERRUPT_Init(void);

//--------------- INITIALIZATION FUNCTIONS ---------------------------------
void GPIO_init(void)
{
	APHCON = (unsigned char)~(C_PA0_PHB ); // Enable PA0 pull-high resistor, Others disable
	IOSTA = C_PA7_Output | C_PA5_Output | C_PA4_Input | C_PA2_Output | C_PA0_Output;
	PORTA = 0xA0;
	
	IOSTB =  C_PB3_Input ;			// Set PB3 as input, Others set as output
	PORTB = 0x08;								
}

void TIM0_Init(void)
{
	PCON1 = C_TMR0_Dis;							// Disable Timer0
	TMR0 = TMR0RELOAD;							// Load 0x00 to TMR0 (Initial Timer0 register)
	T0MD = C_PS0_TMR0 | C_PS0_Div8 ;			// Prescaler0 is assigned to Timer0, Prescaler0 dividing rate = 1:8, Timer0 clock source is instruction clock
	INTFbits.T0IF=0;							// Clear interrupt flag
	PCON1 = C_TMR0_En;							// Enable Timer0
}

void TIM1_Init(void)
{
	TMRH = C_TMR1_Data_b9 | C_TMR1_Data_b8;
	TMR1 = 0x0C;								// Low byte (total count = 0x30D, 10ms timing) (Initial Timer1 register)
	INTFbits.T1IF=0;
	T1CR2 = C_TMR1_ClkSrc_Inst | C_PS1_EN | C_PS1_Div64;	// Enable Prescaler1, Prescaler1 dividing rate = 1:4, Timer1 clock source is instruction clock
	T1CR1 = C_TMR1_Reload | C_TMR1_En;			// Enable Timer1, Initial value reloaded from TMR1, Non-stop mode 
}

void TIM2_Init(void)
{
	TMRH &= ~(C_TMR2_Data_b9 | C_TMR2_Data_b8);
	TMR2 = 0x9F;					// Low byte (total count = 0x50, 128us timing)
	T2CR2 = C_TMR2_ClkSrc_Inst | C_PS2_EN | C_PS2_Div4;	// Timer2 clock source = instruction clock, prescaler 1:8
	INTFbits.T2IF = 0;				// Clear interrupt flag
	T2CR1 = C_TMR2_Reload | C_TMR2_En;			// Enable Timer2 with auto-reload
}

void PWM3_GM(void)
{
	TM3RH		= 0x00;
	TMR3		= 0x27;								// TMR3[9:0] = 3FFh
	PWM3DUTY	= 0x14;								// PWM3DUTY[9:0] = 300h
	T3CR2		= C_PS3_Dis | C_TMR3_ClkSrc_Inst;	// Prescaler 1:1, Timer3 clock source is instruction clock
	T3CR1		= C_PWM3_En | C_PWM3_Active_Hi | C_TMR3_Reload | C_TMR3_En;	// Enable PWM3, Active_High, Non-Stop mode, Reloaded from TMR3[9:0], Enable Timer3
}
void PWM3_FORD(void)
{
	TMR3		= 0x27;								// TMR3[9:0] = 3FFh
	PWM3DUTY	= 0x05;								// PWM3DUTY[9:0] = 300h
	T3CR2		= C_PS3_Dis | C_TMR3_ClkSrc_Inst;	// Prescaler 1:1, Timer3 clock source is instruction clock
	T3CR1		= C_PWM3_En | C_PWM3_Active_Hi | C_TMR3_Reload | C_TMR3_En;	// Enable PWM3, Active_High, Non-Stop mode, Reloaded from TMR3[9:0], Enable Timer3
}

void INTERRUPT_Init(void)
{
	INTE = C_INT_WDT | C_INT_TMR2 | C_INT_TMR1 | C_INT_TMR0;	// Enable Timer0、Timer1、WDT overflow interrupt
	ENI();										// Enable all unmasked interrupts

}

void isr(void) __interrupt(0)
{
	if (INTFbits.T2IF)
	{
		main_cycle_counter = (main_cycle_counter < TOTAL_CYCLES) ? ++main_cycle_counter : 0;
		// High-phase logic
		if(main_cycle_counter < HIGH_CYCLES)
		{
			// Set output state (high if within sub-cycle's active period)
			output_state = (sub_cycle_counter < sub_cycles[sub_cycle_index]) ? 1 : 0;
			
			sub_cycle_counter = (sub_cycle_counter < (sub_cycles[sub_cycle_index] + sub_cycles_low[sub_cycle_index] - 1)) ? ++sub_cycle_counter : 0;
			// Move to next sub-cycle when current ends
			if (sub_cycle_counter == 0) {sub_cycle_index = (sub_cycle_index < SUB_CYCLE_COUNT) ? ++sub_cycle_index : 0 ;}
		}
		else
		{
			sub_cycle_index = 0;  // 清空小周期数组
			sub_cycle_counter = 0;
			output_state = 0;// Disable PWM3
		}
		
		if (FORD_flag)
		{
			T3CR1 = (output_state) ? (T3CR1 | C_PWM3_En) : (T3CR1 & (~C_PWM3_En));
			//if (output_state) {
			//    T3CR1 |= C_PWM3_En;   // Enable PWM3 
			//} else {
			//    T3CR1 &= ~C_PWM3_En;  // Disable PWM3
			//};    
		}
		
		INTFbits.T2IF = 0;
	}
	
	if (INTFbits.T1IF) // 10ms
	{
		timer_count++;
		//FORD_flag = (timer_count > 500) ? 1 : 0;
		if (timer_count == 500) 
		{
			FORD_flag = 1;
			PWM3_FORD();
			ADC_threshold = ADC_THRESHOLD_FORD;
		} 
		else if (timer_count >= 1001)
		{ // 10-second timeout
			FORD_flag = 0;
			timer_count = 0;
			PORTA &= ~(1<<0); // Pull PA0 low to power off
		}
		
		if (red_blink_enable){
			red_led_count++;
			if(red_led_count >= 25)
			{// Red LED blinks at 2Hz
				red_led_count = 0;
				PORTA ^= (1<<5); // Toggle PA5 pin state
			}
		} 
		else
		{
			PORTA |= (1<<5); // PA5 high level to turn off red LED
			red_led_count = 0;
		}
		
		//INTF = (unsigned char)~(C_INT_TMR1); // Clear Timer1 interrupt flag
		INTFbits.T1IF = 0;
	}

	if (INTFbits.T0IF)
	{
		TMR0 = TMR0RELOAD; // Reload TMR0
		//PORTB ^= (1<<0);						// PB0 Toggle
		// Green LED toggle (20Hz)
		green_led_count++;
		green_led_count_Reload = (FORD_flag) ? 25 : 125;
		if (green_led_count >= green_led_count_Reload) 
		{
			green_led_count = 0;
			PORTA ^= (1<<7); // Toggle PA7 pin state
		}
		//INTF = (unsigned char)~(C_INT_TMR0); // Clear Timer0 interrupt flag
		INTFbits.T0IF = 0;
	}

	if (INTFbits.WDTIF)
	{
		//PORTB ^= (1<<2);						// PB2 Toggle
		INTF = (unsigned char)~(C_INT_WDT);		// Clear WDTIF flag
	}
	
	if (ADRbits.ADIF)
	{
		ADRbits.ADIF = 0;							// Clear ADC interrupt flag bit								=> ADIF = ADC[6] = 0
		R_ADC_DATA_HB = ADD;						// RAM"R_ADC_DATA_HB[7:0]" store ADCdata[11:4]
		R_ADC_DATA_LB = 0x0F & ADR;					// RAM"R_ADC_DATA_LB[3:0]" store ADCdata[3:0]
		ADMDbits.START = 1;							// Start a next ADC conversion session						=> ADMD[6] = 1
		
		adc_value = ((unsigned int)R_ADC_DATA_HB << 4) | R_ADC_DATA_LB; // Combine into 12 bits
		red_blink_enable = (ADC_threshold < adc_value) ? 0 : 1;
	}
}



void ADC_init(void)
{
	R_ADC_DATA_HB = R_ADC_DATA_LB = 0x00;		// Initialize RAM
	INTE  = 0x00;								// Disable all interrupt enable bit

	// SELECTION of ADC HIGH-REFERENCE-VOLTAGE(VREFH) SOURCE
//	ADVREFH = C_Vrefh_VDD;						// Reference-high-voltage is supplied by internal VDD		=> VREFH = IntVDD (Note: ADCCLK ∝ 2MHz @ VDD = 5.0V)
//	ADVREFH = C_Vrefh_4V;						//                                       internal 4V		=> VREFH = LDO4V  (Note: ADCCLK ∝ 1MHz)
	ADVREFH = C_Vrefh_3V;						//                                       internal 3V		=> VREFH = LDO3V  (Note: ADCCLK ∝ 500KHz)
//	ADVREFH = C_Vrefh_2V;						//                                       internal 2V		=> VREFH = LDO2V  (Note: ADCCLK ∝ 250KHz)
//	ADVREFH = C_Vrefh_External;					//                                       external pin PA0	=> VREFH = ExtPA0 (Note: ADCCLK must be refer to internal VDD/4V/3V/2V)

	// SELECTION of ADC CLOCK FREQUENCY
//	ADR = C_Ckl_Div1;							// ADCCLK is SYSCLK divided by 1							=> ADCCLK = SYSCLK/1
//	ADR = C_Ckl_Div2;							//                          by 2							=> ADCCLK = SYSCLK/2
//	ADR = C_Ckl_Div8;							//                          by 8							=> ADCCLK = SYSCLK/8
	ADR = C_Ckl_Div16;							//                          by 16							=> ADCCLK = SYSCLK/16

	// SELECTION of ADC SAMPLING-PULSE-WIDTH
//	ADCR = C_Sample_1clk | C_12BIT;				// Sample-pulse-width = 1*ADCCLK, ADC-conversion-bit = 12-bit (Note: ADCCLK ∝ 500KHz)
//	ADCR = C_Sample_2clk | C_12BIT;				//                    = 2*ADCCLK,                    = 12-bit (Note: ADCCLK ∝ 1MHz)
//	ADCR = C_Sample_4clk | C_12BIT;				//                    = 4*ADCCLK,                    = 12-bit (Note: ADCCLK ∝ 1.25MHz)
	ADCR = C_Sample_8clk | C_12BIT; 			//                    = 8*ADCCLK,                    = 12-bit (Note: ADCCLK ∝ 2MHz)

	// INITIALIZATION of ADC FUNCTION
	ADMD  = C_ADC_En | C_ADC_CH_En | C_ADC_PB3;	// Enable ADC power, Enable global ADC input channel, Select AIN1(PA1) as ADC analog input
	//PACON = C_PA1_AIN1;							// Set AIN1(PA1) as pure ADC input for reducing power consumption
	ADCR = C_PB3_AIN8;
	ADRbits.ADIE = 1;							// Enable ADC interrupt bit									=> ADIE = ADR[7] = 1
	ADRbits.ADIF = 0;							// Clear ADC interrupt flag bit								=> ADIF = ADC[6] = 0
	Delay(50);									// Delay 1.12ms (SYSCLK=4MHz/4T) for waiting ADC stable
	ADMDbits.START = 1;							// Start an ADC conversion session							=> ADMD[6] = 1
	ENI();										// Enable all unmasked interrupts	
}



// SUBROUTINE of TIME DELAY
void Delay(unsigned int count)
{
	unsigned int i;

	for(i = 1; i <= count; i++)
	;
}

//--------------- MAIN PROGRAM ---------------------------------------------
void main(void)
{
	// SYSTEM INITIALIZATION
	PCON = C_WDT_En | C_LVR_En;				// Enable WDT & LVR
	DISI();

	// GPIO INITIALIZATION
	GPIO_init();

	// TIMER0 INITIALIZATION
	TIM0_Init();
	
	// TIMER1 INITIALIZATION
	TIM1_Init();
	
	// TIMER2 INITIALIZATION
	TIM2_Init();
	
	// TIMER3 & PWM3 INITIALIZATION
	PWM3_GM();
	
	// ADC INITIALIZATION
	ADC_init();

	system_on = 0;
	green_led_count = 0;
	red_led_count = 0;
	adc_counter = 0;
	timer_count = 0;
	red_blink_enable = 0;
	adc_value = 0;
	R_ADC_DATA_HB = R_ADC_DATA_LB = 0x00; // Initialize RAM
	
	main_cycle_counter = 0;
	sub_cycle_index = 0;
	sub_cycle_counter = 0;
	output_state = 0;
	PORTA |= (1<<0); // PA0 high level for self-locking power supply, ensure PA0 is high

	// WDT INITIALIZATION (if WDT needs prescaler0 dividing rate)
//	T0MD = C_PS0_WDT							// Prescaler0 is assigned to WDT, Prescaler0 dividing rate = 1:2 (WDT select interrupt)


	
	// INTERRUPT INITIALIZATION
	INTERRUPT_Init();

	Delay(10);						// Wait for the port/pins to settle
	KeyResult = (PORTA & 0x10);		// Use a bit mask (b'00001111) to get the status of the columns (bit[3:0]), stores the data

	while (1)
	{
		CLRWDT();								// Clear watchdog timer, which is defined in NY8Common.h
	}
}