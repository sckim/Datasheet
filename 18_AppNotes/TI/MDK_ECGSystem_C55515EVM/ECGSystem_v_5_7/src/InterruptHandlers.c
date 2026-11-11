/*****************************************************************************
 * File Name : InterruptHandler.c                                            
 *  Brief	 : The file includes interrupt service routine for the ECG system 
 * 			- int1_isr -  for Leadoff detection                               
 * 			- saradc_isr -for switch press detection
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

#include "lcd.h"
#include "InterruptHandlers.h"




interrupt void i2c_isr()
{
	return;	
}

interrupt void spi_isr()
{
	return;		
}

interrupt void lcd_isr()
{
	return;		
}

interrupt void uart_isr()
{
	return;		
}

interrupt void int0_isr()
{
	return;		
}

/*-----------------------------------------------------------------------**
** 	FunctionName: int1_isr                                               **
** 	Description : - The INT1 ISR is used to identify the Leadsoff Detect **
** 					condition The ISR sets the LeadOffStatus variable    **
** 					with the current status of Lead                      **
**-----------------------------------------------------------------------*/


interrupt void int1_isr()
{
	extern Uint8 LeadOff_Flag;
	Uint8 i2cRxData[2], pca9535PolReg[2] = {0,0};
	Uint8 A1=0,A2=0,B1=0,B2=0,nA1=0,nA2=0,nB1=0,nB2 =0, PortA =0, PortB = 0;
	extern Uint16 LeadOffStatus;

	i2cRxData[0] = 0;
	i2cRxData[1] = 0;

	/*  Read PolarityPort0*/
	i2c_read_reg(CMD_PCA9535_PIP0,&pca9535PolReg[0]);
	/*  Read PolarityPort1*/
	i2c_read_reg(CMD_PCA9535_PIP1,&pca9535PolReg[1]);
	
	i2cRxData[0] = 0;
	i2cRxData[1] = 0;

	/*  Read InPort0*/
	i2c_read_reg(CMD_PCA9535_IP0,&i2cRxData[0]);
	/*  Read InPort1*/
	i2c_read_reg(CMD_PCA9535_IP1,&i2cRxData[1]);

	/* Getting the Leadoff value by XOR ing with the corresponding
	   Polarity register value so as to avoid any polarity changes */
	
	A1 = i2cRxData[0];
	A2 = i2cRxData[1];
	B1 = pca9535PolReg[0];
	B2 = pca9535PolReg[1];

	nA1 = LEADOFFMASK - i2cRxData[0];
	nA2 = LEADOFFMASK - i2cRxData[1];
	nB1 = LEADOFFMASK - pca9535PolReg[0];
	nB2 = LEADOFFMASK - pca9535PolReg[1];

	PortA = ( nA1 & B1 ) | (A1 & nB1);
	PortB = ( nA2 & B2 ) | (A2 & nB2);

	LeadOffStatus =  ((PortB << 8) | PortA);

	LeadOff_Flag = 1;


	/* Clear the interrupt Flag*/ 
	//*CPU_IFR0_ADDR = *CPU_IFR0_ADDR | 0x0008;   

	return;		
}



interrupt void tim0_isr()
{
//	*GPIO_DOUT0_ADDR = *GPIO_DOUT0_ADDR | GPIO7SET;
	/* Call the ECG system function for processing*/
    ECG_System();
 
	/*	Clear Timer0 bit in Timer Aggregate register*/
	*CPU_TIMINT_AGGR = *CPU_TIMINT_AGGR | 0x0001 ;	

//	*GPIO_DOUT0_ADDR = *GPIO_DOUT0_ADDR & GPIO7CLR;
	return;		
}

/*----------------------------------------------------------------------**
** 	Function Name : saradc_isr                                          **
** 	Description : 	-   The SARADC ISR is used to identify the switch   **
** 						Detection whenever a switch is pressed by user. **
** 						The ISR sets the KeyCount and Zoom Flag         **
** 						according to the switches  selected by the user **
** 	                                                                    **
**----------------------------------------------------------------------*/
   
interrupt void saradc_isr()
{

	Uint16 key;
	static int flag =1;
	extern Uint8 Key_Count;
	extern Uint8 Zoom_Flag;
	extern Uint8 col;
	if(flag== 0)
	{
		flag=1;
	}
	else
	{ 
		flag=0;
	}

	if(flag == 1)
	{
		key = Get_Sar_Key();  


        if(key < (SW8 - 0x30))
        {
            /* interrupt for change of Leads in LCD display*/
          	Key_Count ++;
			if(Key_Count >= 12)
			{
				Key_Count = 0;
			}
			if(Key_Count == 0 )
			{
				//LCD_clear_window(4,13,4+8*3,13+8);
				draw_string(4,13," II",BLUE);
			}
			else if(Key_Count == 1)
			{
				//LCD_clear_window(4,13,4+8*3,13+8);
				draw_string(4,13,"  I",BLUE);
			}
			else if(Key_Count == 2)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13,"III",BLUE);
			}
			else if(Key_Count == 3)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13,"aVR",BLUE);
			}
			else if(Key_Count == 4)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13,"aVL",BLUE);
			}
			else if(Key_Count == 5)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13,"aVF",BLUE);
			}
			else if(Key_Count == 6)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13," V1",BLUE);
			}
			else if(Key_Count == 7)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13," V2",BLUE);
			}
			else if(Key_Count == 8)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13," V3",BLUE);
			}
			else if(Key_Count == 9)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13," V4",BLUE);
			}
			else if(Key_Count == 10)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13," V5",BLUE);
			}
			else if(Key_Count == 11)
			{
				//LCD_clear_window(0,13,30,22);
				draw_string(4,13," V6",BLUE);
			}
			//wait(200);
			LCD_clear_window(0,22,128,128);
			col = 0;
        }
        else 
        {
            /*interrupt for Change of Zoom of LCD display*/
			if(Zoom_Flag==0)
			{
				Zoom_Flag = 1;
			}
			else
			if(Zoom_Flag==1)
			{
				Zoom_Flag = 2;
			}
			else
			if(Zoom_Flag==2)
			{
				Zoom_Flag = 0;
			}
         }
     
 
        //wait(1000); // delay2 2000 * 20


  	    Init_SAR();    
	}

	return;		
}
