/*****************************************************************************
 * File Name : lcd.h 
 *
 * Brief	 : The file declares all the functions defined in the lcd.c 
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

#ifndef _LCD_H
#define _LCD_H

#include "psp_common.h"
#include "csl_ioport.h"
#include "corazon.h"
#include "cslr.h"
#include "LCD_FontTable.h"


#define DISPLAY_WIDTH           128
#define DISPLAY_HEIGHT          128

//#define LCD_HEIGHT   128
//#define LCD_WIDTH    128

#define WHITE 0x3F3F3F
#define BLACK 0
#define RED 0x3F0000
#define GREEN 0x003F00
#define BLUE 0x00003F

#define UP_KEY 				0x0001
#define DOWN_KEY 			0x0002
#define ENTER_KEY			0x0004
#define PREVIOUS_KEY		0x0008

#define ECG_FE				0x0003
#define STETHO_FE			0x0002
#define PULSE_OXY_FE		0x0001
#define INCREMENT_LEAD		+1
#define DECREMENT_LEAD		-1
#define WAVEFORM_START_ROW	44
#define WAVEFORM_END_ROW	128
#define WAVEFORM_START_COL	0
#define WAVEFORM_END_COL	128


void Init_LCD(void );
void draw_string (Uint16 , Uint16 , char* ,Uint32 );
void draw_font(Uint16, Uint16, Uint16,Uint32);
Int32 drawLine( Uint16 , Uint16, Uint16, Uint16, Uint16, Uint16);
void  cmdWrite(Uint16);
void  dataWrite(Uint16);
//void LCD_hr_status_update(void);
void LCD_clear_window(Uint16,Uint16,Uint16,Uint16);
void ECG_DisplayLCDStartUpScreen();
/*	function give wait cycles*/
extern void wait(Uint32);
void draw_font_HR(Uint16, Uint16, Uint16,Uint32);
void lcd_remove_waveform(Uint16 col, Uint16 Amplitude, Uint16 row_amplitude_old, Uint16 row_amplitude);
#endif
