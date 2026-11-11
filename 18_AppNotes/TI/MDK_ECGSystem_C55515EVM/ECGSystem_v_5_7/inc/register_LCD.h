/*****************************************************************************
 * File Name : register_LCD.h 
 *
 * Brief	 : Definitions of LCD registers 
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

#ifndef _REG_LCD_H_
#define _REG_LCD_H_


//**************************************************************************\
//* LCD Registers 
//**************************************************************************/

#define LCDREVMIN           *(ioport volatile Uint16*)(0x2E00) // LCD Minor Revision Register
#define LCDREVMAJ           *(ioport volatile Uint16*)(0x2E01) // LCD Major Revision Register
#define LCDCR               *(ioport volatile Uint16*)(0x2E04) // LCD Control Register
#define LCDSR               *(ioport volatile Uint16*)(0x2E08) // LCD Status Register
#define LCDLIDDCR           *(ioport volatile Uint16*)(0x2E0C) // LCD LIDD Control Register
#define LCDLIDDCS0CONFIG0   *(ioport volatile Uint16*)(0x2E10) // LCD LIDD CS0 Configuration Register 0
#define LCDLIDDCS0CONFIG1   *(ioport volatile Uint16*)(0x2E11) // LCD LIDD CS0 Configuration Register 1
#define LCDLIDDCS0ADDR      *(ioport volatile Uint16*)(0x2E14) // LCD LIDD CS0 Address Read/Write Section Register
#define LCDLIDDCS0DATA      *(ioport volatile Uint16*)(0x2E18) // LCD LIDD CS0 Data Read/Write Register
#define LCDLIDDCS1CONFIG0   *(ioport volatile Uint16*)(0x2E1C) // LCD LIDD CS1 Configuration Register 0
#define LCDLIDDCS1CONFIG1   *(ioport volatile Uint16*)(0x2E1D) // LCD LIDD CS1 Configuration Register
#define LCDLIDDCS1ADDR      *(ioport volatile Uint16*)(0x2E20) // LCD LIDD CS1 Address Read/Write Register
#define LCDLIDDCS1DATA      *(ioport volatile Uint16*)(0x2E24) // LCD LIDD CS1 Data Read/Write Register
#define LCDDMACR            *(ioport volatile Uint16*)(0x2E40) // LCD DMA Control Register
#define LCDDMAFB0BAR0       *(ioport volatile Uint16*)(0x2E44) // LCD DMA Frame Buffer 0 Base Address Register 0
#define LCDDMAFB0BAR1       *(ioport volatile Uint16*)(0x2E45) // LCD DMA Frame Buffer 0 Base Address Register 1
#define LCDDMAFB0CAR0       *(ioport volatile Uint16*)(0x2E48) // LCD DMA Frame Buffer 0 Ceiling Address Register 0
#define LCDDMAFB0CAR1       *(ioport volatile Uint16*)(0x2E49) // LCD DMA Frame Buffer 0 Ceiling Address Register 1
#define LCDDMAFB1BAR0       *(ioport volatile Uint16*)(0x2E4C) // LCD DMA Frame Buffer 1 Base Address Register 0
#define LCDDMAFB1BAR1       *(ioport volatile Uint16*)(0x2E4D) // LCD DMA Frame Buffer 1 Base Address Register 1
#define LCDDMAFB1CAR0       *(ioport volatile Uint16*)(0x2E50) // LCD DMA Frame Buffer 1 Ceiling Address Register 0
#define LCDDMAFB1CAR1       *(ioport volatile Uint16*)(0x2E51) // LCD DMA Frame Buffer 1 Ceiling Address Register 1
#endif
