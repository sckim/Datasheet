/*****************************************************************************
 * File Name : ECGGlobals.h 
 *
 * Brief	 : Global definitions used for ECG System
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


#ifndef _ECGGLOBALS_H
#define _ECGGLOBALS_H

/* sampling rate for each channels*/
#define SAMPLING_RATE (500)
/* Aqsn Buff size*/
#define AQSNBUFFSIZE ((2) * MAXCHAN )//(SAMPLING_RATE)//FILTERORDER
/* Lead Info buff size*/
#define LEADINFOSIZE (SAMPLING_RATE/2)
/* Maximum No of Channels aquired from ADS1258 */
#define MAXCHAN (8)
/* Maximum Leads available*/
#define MAXLEAD MAXCHAN
/* Filter order*/
#define FILTERORDER (351)
/* DC Removal Numerator Coeff*/
#define NRCOEFF (0.992)
/* Decimation Factor*/
#define DECIMATOR (1)
/* Unit Voltage represented by ADS*/
#define UNITVOLT (3165.512)
/* Integer equivalent of max possible hex val*/
#define MAXHEXVAL (16777261)
/* ECG Success Status*/
#define ECG_OK 0
/* PCA9535 I2C Expander Address*/
#define I2C_ECGFE_ADDR (0x20)
/* SPI Success Status*/
#define SPI_SUCCESS 0
/* Amplification factor for signal - not used*/
#define AMP_FACTOR (500)
/*2sec of new ECG samples are stored in total of 6s*/
//#define REFRESH_HR_TIME 	2
#define MAX_HEART_RATE		240
#define MIN_HEART_RATE		30
/*threshold = 0.6 * maxima*/
#define QRS_THRESHOLD_FRACTION	0.7					
/*70 samples are skipped without threshold detection after getting a maxima*/
#define MINIMUM_SKIP_WINDOW		50	//30			
/*search for maxima is done for 20 samples after crossing the threshold*/
#define MAXIMA_SEARCH_WINDOW	40	//7				
/*Scaling Factor for the First Derivative*/
#define FD_SCALE_FACTOR		1					
/*Scaling Factor for the Second derivative*/
#define SD_SCALE_FACTOR		1					
/*length of the array which stores Sample index S1,S2........*/
#define SI_ARRAY_LENGTH		((MAX_HEART_RATE / 60) * TOTAL_STORAGE_TIME ) 
/*Zoom factor in max condition*/
#define HIGH  650 //	625	for old filtering method				
/*Default setting for medium Zoom set as default*/
#define MEDIUM	1300 //1250 for old filtering method
/*Default setting for least Zoom*/
#define LOW		2600//2500	for old filtering method			
/*Total of 6s of data are stored for running HR calculation Algorithm*/
//#define TOTAL_STORAGE_TIME 	6					
/*call QRS when 117 samples are filled in Lead_Info Buffer*/
//#define FIRST_QRS_CALL 		(LEADINFOSIZE/3)				
/*call QRS when 234 samples are filled in Lead_Info Buffer		*/
//#define SECOND_QRS_CALL 	(2*(LEADINFOSIZE/3))			
/*call QRS when 351 samples are filled in Lead_Info Buffer*/
//#define THIRD_QRS_CALL 		(3*(LEADINFOSIZE/3))
/* QRS call factor*/
#define QRSCALLFACT (LEADINFOSIZE/10)	
/* Hex value corresponding to Lead-Off condition of Right Arm*/
#define ELECTRODE_RA 		0x01FE
/* Hex value corresponding to Lead-Off condition of Left Arm*/
#define ELECTRODE_LA 		0x01FD
/* Hex value corresponding to Lead-Off condition of Left Leg*/
#define ELECTRODE_LL 		0x01FB
/* Hex value corresponding to Lead-Off condition of V1*/
#define ELECTRODE_V1 		0x01F7
/* Hex value corresponding to Lead-Off condition of V2*/
#define ELECTRODE_V2 		0x01EF
/* Hex value corresponding to Lead-Off condition of V3*/
#define ELECTRODE_V3 		0x01DF
/* Hex value corresponding to Lead-Off condition of V4*/
#define ELECTRODE_V4 		0x01BF
/* Hex value corresponding to Lead-Off condition of V5*/
#define ELECTRODE_V5 		0x017F
/* Hex value corresponding to Lead-Off condition of V6*/
#define ELECTRODE_V6 		0x00FF
/* MASK for Leadoff*/
#define LEADOFFMASK 0xFFFF
/*  0 for Notch @ 50Hz  and 1 for Notch @ 60Hz*/
#define NOTCHFILTERSEL 0   

#define GPIO7SET 0x0080
#define GPIO8SET 0x0100
#define GPIO7CLR 0xFF7F
#define GPIO8CLR 0xFEFF		

#endif
