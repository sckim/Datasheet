/*****************************************************************************
 * File Name : SAR.c                                                         
 *  Brief	 : The file includes two function which is done on SAR peripheral 
 * 			- Init_SAR -  A initialization of SAR registers                   
 * 			- Get_Sar_Key - Getting the value of currently pressed key 
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

#include <stdio.h>
#include <std.h>
#include "stdtypes.h"
#include "sar.h"  

/*-----------------------------------------------------------------**
** 	Function  Name: Init_SAR                                       **
** 	Description : 	- 	The function initializes the SAR module to **
** 						select GPAIN1(AIN3) Also set the saradc    **
** 						interrupt for all key press                **
** 	Parameters	:	- 	None                                       **
**                                                                 **
**-----------------------------------------------------------------*/

void Init_SAR(void)
{
   	
	
  	*SARCTRL = 0x0000;		/* reset the CTRL Reg */
    *SARCTRL = 0x3400; 		/* select AIN3, which is GPAIN1 */
	*SARCLKCTRL = 0x0064;   /* 100/100 = 1MHz */ 
    *SARPINCTRL = 0x7104;   /* Set the AD reference & PIN control values */
    *SARGPOCTRL = 0x0100;   /* Set the PEN interrupt */
 

   
}

/*---------------------------------------------------------------------**
** 	Function Name : Get_Sar_Key                                        **
** 	Description : 	- 	This function reads the value corresponding to **
** 						the selected switch Also set the saradc        **
** 						interrupt for all key press.                   **
**                                                                     **
** 	Parameters	:	- None                                             **
**                                                                     **
**---------------------------------------------------------------------*/

Uint16 Get_Sar_Key(void)
{
    Uint16 val, i;

  	*SARCTRL = 0xB400;   
  
  while(1)
    {
        for(i=0;i<1500; i++)
            asm("	nop");     
        val = *SARDATA;
        if((val&0x8000) == 0)
            break;
    }

    return(val);
}
