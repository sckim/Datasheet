/*****************************************************************************
 * File Name : oled.h 
 *
 * Brief	 : LCD Header file 
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


/* ------------------------------------------------------------------------ *
 *  LCD Module Command                                                    *
 * ------------------------------------------------------------------------ */
 
#define DISPLAY_WIDTH           128
#define DISPLAY_HEIGHT          128

#define SSD1351         1

// OLDE controller command
#if (SSD1351 ==1)
#define SET_COL_ADD             0x15
#define SET_ROW_ADD             0x75
#define WRITE_COMMAND           0x5C
#define READ_COMMAND            0x5D
#define SET_REMAP               0xA0
#define SET_DISP_START_LINE     0xA1
#define SET_DISP_OFFSET         0xA2
#define SET_DISP_OFF            0xA4
#define SET_DISP_GRAY           0xA5
#define SET_DISP_NORMAL         0xA6
#define SET_DISP_INVERSE        0xA7
#define NOP                     0xAD
#define FUNCTION_SEL            0xAB
#define SLEEP_MODE_ON           0xAE
#define SLEEP_MODE_OFF          0xAF               
#define SET_PRECHARGE_PERIOD1   0xB1
#define ENHANCE_DRIVE           0xB2
#define SET_CLOCK               0xB3
#define SET_SEG_LOW_VOL         0xB4
#define SET_GPIO                0xB5
#define SET_PRECHARGE_PERIOD2   0xB6
#define SET_GRAY_LUT            0xB8
#define USB_BUILT_IN_LUT        0xB9
#define SET_PRECHARGE_VOL       0xBB
#define SET_VCOM_VOL            0xBE
#define SET_CNTRAST_COLOR       0xC1
#define MASTER_CNTRAST          0xC7
#define SET_MUX_RATIO           0xCA
#define SET_CMD_LOCK            0xFD
#define HORIZONTAL_SCROLL       0x96
#define STOP_MOVE               0x9E
#define START_MOVE              0x9F   

#endif
