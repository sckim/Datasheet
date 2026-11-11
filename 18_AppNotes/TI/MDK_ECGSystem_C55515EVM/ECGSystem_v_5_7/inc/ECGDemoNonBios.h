/*****************************************************************************
 * File Name : ECGDemoNonBios.h 
 *
 * Brief	 : Definitions used for ECGSystem_main, common variables, buffer and 
 *            function declaration
 *
 * Copyright (C) 2009 -2010 Texas Instruments Incorporated - http://www.ti.com/ 
 * 
 * 
 *  Redistribution and use in source and binary forms, with or without 
 *  modification, are permitted provided that the following conditions 
 *  are met:
 *
 *    Redistributions of source code must retain the above copyright 
 *    notice, this list of conditions and the following disclaimer.
 *
 *    Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the 
 *    documentation and/or other materials provided with the   
 *    distribution.
 *
 *    Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
 *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
 *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
******************************************************************************/


#ifndef _ECGDEMONONBIOS_H
#define _ECGDEMONONBIOS_H

#include<stdio.h>
#include<math.h>
#include<file.h>
#include<stdio.h>
#include<std.h>
#include "psp_common.h"
#include "cpu_clock_init.h"
#include "dda_spi.h"
#include "llc_spi.h"
//#include "cpu_power.h"
#include "csl_ioport.h"
#include "corazon.h"
#include "cslr.h"
#include "LCD_FontTable.h"
#include "ECGGlobals.h"
#include "ADS1258.h"
#include "typedef.h"
#include "timer.h"
#include "psp_uart.h"
#include "dda_uart.h"



/* Function to toggle GPIO according to channel*/
void ECG_ToggleGPIO(Uint8);
/* function to process samples for 1 sec*/	
ECG_Status ECG_System();	
/* function to read channel data*/	 		
extern void ADS1258_Read_ChannelData(Uint8*,Uint8*);
/* convert the 4 byte channel data to 24bit sample*/
extern Int32 ECG_GetCurrAqsnSample(Uint8*);
/* process the current sample*/
extern void ECG_ProcessCurrSample(Uint32,Uint8,Uint32, Uint32);
/* function which is called by the main thread at filling of every(N/3) */
/* samples in Lead_Info_Buffer                                          */
extern void QRS_Algorithm_Interface(Uint32);
/* plot the current sample in LCD*/
extern void ECG_LCDPlotCurrSample(Uint32,Uint32);
/* Send the LeadInfo thru UART to plot in the PC Application*/
extern void ECG_UARTTxCurrSamples(Uint32,Uint32);
/*Function to display the HR Rate on LCD*/
void ECG_LCD_HRDisplay(void);
/*Function to display the Lead Off status on LCD*/
void ECG_LCD_LeadOffDisplay(void);
/* function to initialize peripherals*/
extern ECG_Status ECG_C5505Init();	
/* function to display LCD startup screen*/
extern void ECG_DisplayLCDStartUpScreen();
/* function to Initialize the timer*/
extern void ECG_TIMER_INIT();

#endif



















