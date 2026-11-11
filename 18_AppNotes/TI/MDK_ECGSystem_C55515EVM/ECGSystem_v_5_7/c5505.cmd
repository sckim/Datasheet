/*****************************************************************************
 * File Name : c5505.cmd 
 *
 * Brief	 : Command Link File
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

/*-c
/*-stack 0x7000                   /* PRIMARY STACK SIZE               */
/*-sstack 0x1000                /* SECONDARY STACK SIZE             */
/*-heap  0x1000                   /* HEAP AREA SIZE  */  


_RTDX_interrupt_mask = ~0x06000010;

/* Set entry point to Reset vector                                  */
/* - Allows Reset ISR to force IVPD/IVPH to point to vector table.  */
/*-e reset_isr */

MEMORY
{
    MMR     (RW) : origin = 0000000h length = 0000c0h /* MMRs */
    VEC     (RX) : origin = 00000C0h length = 000300h /* on-chip ROM vectors */
    
/*    DARAM_0 (RW) : origin = 0000400h length = 001A00h /* on-chip DARAM 0 */
/*    DARAM_1 (RW) : origin = 0002000h length = 002000h /* on-chip DARAM 1 */
/*   DARAM_2 (RW) : origin = 0004000h length = 002000h /* on-chip DARAM 2 */
/*    DARAM_3 (RW) : origin = 0006000h length = 00A000h /* on-chip DARAM 3 */
/*    DARAM_3 (RW) : origin = 0006000h length = 002000h /* on-chip DARAM 3 */
/*    DARAM_4 (RW) : origin = 0008000h length = 002000h /* on-chip DARAM 4 */
/*    DARAM_5 (RW) : origin = 000A000h length = 002000h /* on-chip DARAM 5 */
/*    DARAM_6 (RW) : origin = 000C000h length = 002000h /* on-chip DARAM 6 */
/*    DARAM_7 (RW) : origin = 000e000h length = 002000h /* on-chip DARAM 7 */
    
    DARAM (RW)    : origin = 0000400h length = 00fa00h  /* on-chip DARAM */

    SARAM_0 (RW)  : origin = 0010000h length = 002000h  /* on-chip SARAM 0 */
    SARAM_1 (RW)  : origin = 0012000h length = 002000h  /* on-chip SARAM 1 */
    SARAM_2 (RW)  : origin = 0014000h length = 002000h  /* on-chip SARAM 2 */
    SARAM_3 (RW)  : origin = 0016000h length = 034000h  /* on-chip SARAM 3 */

/*    SARAM_4 (RW)  : origin = 0018000h length = 002000h  /* on-chip SARAM 4 */
/*    SARAM_5 (RW)  : origin = 001A000h length = 002000h  /* on-chip SARAM 5 */
/*    SARAM_6 (RW)  : origin = 001C000h length = 002000h  /* on-chip SARAM 6 */
/*    SARAM_7 (RW)  : origin = 001e000h length = 002000h  /* on-chip SARAM 7 */

/*    SARAM_8 (RW)  : origin = 0020000h length = 002000h  /* on-chip SARAM 8 */
/*    SARAM_9 (RW)  : origin = 0022000h length = 002000h  /* on-chip SARAM 9 */
/*    SARAM_10 (RW) : origin = 0024000h length = 002000h  /* on-chip SARAM 10 */
/*sree    SARAM_11 (RW) : origin = 0026000h length = 010000h  /* on-chip SARAM 11 */

/*    SARAM_12 (RW) : origin = 0028000h length = 002000h  /* on-chip SARAM 12 */
/*    SARAM_13 (RW) : origin = 002A000h length = 002000h  /* on-chip SARAM 13 */
/*    SARAM_14 (RW) : origin = 002C000h length = 002000h  /* on-chip SARAM 14 */
/*    SARAM_15 (RW) : origin = 002e000h length = 002000h  /* on-chip SARAM 15 */

/*    SARAM_16 (RW) : origin = 0030000h length = 002000h  /* on-chip SARAM 16 */
/*    SARAM_17 (RW) : origin = 0032000h length = 002000h  /* on-chip SARAM 17 */
/*    SARAM_18 (RW) : origin = 0034000h length = 002000h  /* on-chip SARAM 18 */
/*sree    SARAM_19 (RW) : origin = 0036000h length = 00C000h  /* on-chip SARAM 19 */

/*    SARAM_20 (RW) : origin = 0038000h length = 002000h  /* on-chip SARAM 20 */
/*    SARAM_21 (RW) : origin = 003A000h length = 002000h  /* on-chip SARAM 21 */
/*    SARAM_22 (RW) : origin = 003C000h length = 002000h  /* on-chip SARAM 22 */
/*    SARAM_23 (RW) : origin = 003e000h length = 002000h  /* on-chip SARAM 23 */

/*    SARAM_24 (RW) : origin = 0040000h length = 002000h  /* on-chip SARAM 24 */
/*sree    SARAM_25 (RW) : origin = 0042000h length = 00C000h  /* on-chip SARAM 25 */
/*    SARAM_26 (RW) : origin = 0044000h length = 002000h  /* on-chip SARAM 26 */
/*    SARAM_27 (RW) : origin = 0046000h length = 002000h  /* on-chip SARAM 27 */

/*    SARAM_28 (RW) : origin = 0048000h length = 002000h  /* on-chip SARAM 28 */
/*    SARAM_29 (RW) : origin = 004A000h length = 002000h  /* on-chip SARAM 29 */
/*    SARAM_30 (RW) : origin = 004C000h length = 002000h  /* on-chip SARAM 30 */
/*sree    SARAM_31 (RW) : origin = 004E000h length = 002000h  /* on-chip SARAM 31 */

   /* SARAM   (RW)  : origin = 0010000h length = 040000h *//* on-chip SARAM */

    SAROM_0 (RX)  : origin = 0fe0000h length = 008000h 	/* on-chip ROM 0 */
    SAROM_1 (RX)  : origin = 0fe8000h length = 008000h 	/* on-chip ROM 1 */
    SAROM_2 (RX)  : origin = 0ff0000h length = 008000h 	/* on-chip ROM 2 */
    SAROM_3 (RX)  : origin = 0ff8000h length = 008000h 	/* on-chip ROM 3 */
    
    EMIF_CS0 (RW)  : origin = 0050000h  length = 07B0000h   /* mSDR */ 
	EMIF_CS2 (RW)  : origin = 0800000h  length = 0400000h   /* ASYNC1 : NAND */ 
	EMIF_CS3 (RW)  : origin = 0C00000h  length = 0200000h   /* ASYNC2 : NOR  */
	EMIF_CS4 (RW)  : origin = 0E00000h  length = 0100000h   /* ASYNC3 : SRAM */
	EMIF_CS5 (RW)  : origin = 0F00000h  length = 00E0000h   /* ASYNC4 : SRAM */

}


SECTIONS
{
    vectors     : > VEC 	 
    .text       : > DARAM  ALIGN = 4
    stack       : > DARAM  ALIGN = 2
    sstack      : > DARAM  ALIGN = 2
	
	.switch		: > SARAM_3
    .data       : > DARAM
    .bss        : > SARAM_3, fill = 0
	.cinit 		: > SARAM_3
	.const 		: > DARAM
	.cio		: > DARAM
	 sysmem 	: > DARAM
	.WorkBuffer : > DARAM
	.Coeff		: > DARAM
/*    .rtdx_text       > SARAM_0               */
/*	.rtdx_data       > DARAM_2 fill=0xBEEF    */
/*	 rtdx_data       > SARAM_*/
/*	.pinit           > SARAM_0  */
    

/*	.buffer1   	: > DARAM_2
	.buffer2   	: > DARAM_2 
	.buffer3   	: > DARAM_3
	.buffer4   	: > DARAM_3
	.buffer5   	: > DARAM_4
	.buffer6   	: > DARAM_5
	.buffer7   	: > DARAM_6
	.buffer8   	: > DARAM_7
	.buffer11  	: > SARAM_2
	.buffer12  	: > SARAM_3
	.buffer13  	: > SARAM_4
	.buffer14  	: > SARAM_5
	.buffer15  	: > SARAM_6
	.buffer16  	: > SARAM_7
	.buffer17  	: > SARAM_8
	.buffer18  	: > SARAM_9
	.buffer19  	: > SARAM_10
	.buffer20  	: > SARAM_11
	.buffer21  	: > SARAM_12
	.buffer22  	: > SARAM_13
	.buffer23  	: > SARAM_14
	.buffer24  	: > SARAM_15
	.buffer25  	: > SARAM_16
	.buffer26  	: > SARAM_17
	.buffer27  	: > SARAM_18 
	.buffer28  	: > SARAM_19
	.buffer29  	: > SARAM_20
	.buffer30  	: > SARAM_21
	.buffer31  	: > SARAM_22
	.buffer32  	: > SARAM_23
	.buffer33  	: > SARAM_24 
	.buffer34  	: > SARAM_25
	.buffer35  	: > SARAM_26
	.buffer36  	: > SARAM_27
	.buffer37  	: > SARAM_28
	.buffer38  	: > SARAM_29
	.buffer39  	: > SARAM_30 
	.buffer40  	: > SARAM_31 */
	.emif_cs0   : > EMIF_CS0
	.emif_cs2   : > EMIF_CS2
	.emif_cs3   : > EMIF_CS3
	.emif_cs4   : > EMIF_CS4
	.emif_cs5   : > EMIF_CS5


}
