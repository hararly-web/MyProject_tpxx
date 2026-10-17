/* =========================================================================
 * Project:		Low Voltage Detect (LVD)
 * File:		main.c
 * Author:		Ranley
 * Version:		v1.1
 * Date:		2022/11/02
 * Description:
 *	1. Polling LVD Status: When VDD voltage > LVD voltage, Then PB0 output high.
 *	                       When VDD voltage < LVD voltage, Then PB0 output low.
 *	2. Using Power noise bypass capacitor (0.1uF) between VDD and GND.
 *	3. Set LVD = 3.0V.
 *		LVDS[2:0] = 000b	=> LVD  2.0V
 *					001b			2.2V
 *					010b			2.4V
 *					011b			2.7V
 *					100b			3.0V
 *					101b			3.3V
 *					110b			3.6V
 *					111b			4.3V
 =========================================================================*/
//--------------- FILE INCLUDE ---------------------------------------------
#include <ny8.h>
#include "NY8_constant.h"

//--------------- MAIN PROGRAM ---------------------------------------------
void main(void)
{
	// SYSTEM INITIALIZATION
	PORTB = 0x00;
	IOSTB = C_PB_Output;				// PortB outputs Low
	DISI();								// Disable all unmasked interrupts
	INTE = 0x00;						// Disabl interrupt enable register

	// LVD INITIALIZATION
	PCONbits.LVDEN = 1;					// Enable LVD
	PCON1 = C_LVD_3P0V;					// Set LVDS[2:0]=100b(3.0V), Timer0 disable

	// POLLING LVD STATUS
	while (1)
	{
		if (PCON1 & 0x40)
			PORTBbits.PB0 = 1;			// LVDOUT=PCON1[6]=1	=> PB0=1
		else
			PORTBbits.PB0 = 0;			// LVDOUT=PCON1[6]=0	=> PB0=0
		CLRWDT();						// Clear watchdog timer, which is defined in NY8Common.h
	}
}