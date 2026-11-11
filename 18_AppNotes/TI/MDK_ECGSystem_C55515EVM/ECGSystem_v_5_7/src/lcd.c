/*****************************************************************************
 * File Name : lcd.c                                                         
 *  Brief	 : The file includes all the LCD functions for the ECG system  
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
#include "oled.h"
#include "register_LCD.h"


extern Uint32 QRS_Heart_Rate;


void  cmdWrite(Uint16 cmd)
{
    // Chip Select 0 
    LCDLIDDCS0ADDR = cmd;
}      

void  dataWrite(Uint16 data)
{
    // Chip Select 0
    LCDLIDDCS0DATA = data;
} 

void lcd_clear(void)
{
    int i, j;
    
    cmdWrite(SET_COL_ADD);
	dataWrite(0);
	dataWrite(DISPLAY_WIDTH-1);        
	wait(10);     

	cmdWrite(SET_ROW_ADD); 
	dataWrite(0);
	dataWrite(DISPLAY_HEIGHT-1);
	wait(10);

	cmdWrite(WRITE_COMMAND);            // Enable MCU to Write into RAM	 
	
	for(i=0;i<DISPLAY_HEIGHT;i++)
	{
		for(j=0;j<DISPLAY_WIDTH;j++)
		{
		    dataWrite(0);
		    dataWrite(0);
		    dataWrite(0);
		}
	}		
}

void lcd_remove_waveform(Uint16 col, Uint16 Amplitude, Uint16 row_amplitude_old, Uint16 row_amplitude)
{
	Uint16 j;
			
			if(Amplitude >= 2 )
			{
// save time for C5515 EVM   
				cmdWrite(SET_COL_ADD); /* row address */
				dataWrite(col);
				dataWrite(col);
				cmdWrite(SET_ROW_ADD);/* col. address */
				if(row_amplitude > row_amplitude_old)
				{
			        dataWrite(22+row_amplitude_old);
			        dataWrite(22+row_amplitude_old+Amplitude);

			    }
			    else
			    {
			        dataWrite(22+row_amplitude_old-Amplitude);
			        dataWrite(22+row_amplitude_old);

			    }
			    cmdWrite(WRITE_COMMAND);

				for(j = 0 ;j < (Amplitude - 1);j++)
	    		{
					dataWrite(0);
					dataWrite(0);
					dataWrite(0);
	    		}			    
			}
			else
			{
			    cmdWrite(SET_COL_ADD);
			    dataWrite(col);
			    dataWrite(col);
                
			    cmdWrite(SET_ROW_ADD);
			    dataWrite(22+row_amplitude);
			    dataWrite(22+row_amplitude);
                
			    cmdWrite(WRITE_COMMAND);
			    /* glow the pixel corresponding to that row */
		   	    dataWrite(0);
		   	    dataWrite(0);
		   	    dataWrite(0);
			}
}

void ECG_DisplayLCDStartUpScreen()
{
	
	//wait(1000);
	lcd_clear();		/* Clear the LCD */
	wait(5000);

	/* Display the startup screen on LCD*/
	draw_string(30,3,"ECG",BLUE);		
	wait(5000);
	draw_string(55,3," MONITOR",BLUE);
	wait(5000);
	//draw_string(58,13,"HR:",BLUE);		
	//wait(5000);
	draw_string(106,13,"BPM",BLUE);
	wait(5000);
 	draw_string(1,13," II",BLUE);
	/*Green Circle indicating Lead_Off Status*/
	draw_font(45,13,38,GREEN);			
	wait(5000);

}


/*--------------------------------------------------------------------------------------------**
** 	FunctionName: Init_LCD                                                                    **
** 	Description : 	- The function initializes the LCD controller for the LCD used in the EVM **
** 	Parameters	:	- cs_flag - In - 0                                                        **
** 	                                                                                          **
**                                                                                            **
**--------------------------------------------------------------------------------------------*/
	
		
void Init_LCD(void)      
{
	// Set AsyncMPU80 mode
	//LCDLIDDCR &= ~0x07;
	//LCDLIDDCR |=  0x03;
	
	// Max out strobe, setup and hold timings

	//LCDLIDDCS0CONFIG0 = 0xFFFD;  // Read Strobe Set-Up cycles, Read Strobe Duration cycles, Read Strobe Hold cycles, number of LCD_CLK cycles between the end of one CS0
	//LCDLIDDCS0CONFIG1 = 0x7FFF;  // Write
	
	*(ioport volatile unsigned *)0x1c0A &= 0xF7FF;		/*Set GPIO11 = 0*/
	wait(1000);
	*(ioport volatile unsigned *)0x1c0A |= 0x800; 		/*Set GPIO11 = 1*/
	wait(5000);
	

	cmdWrite(SET_CMD_LOCK);     // Command Lock
	dataWrite(0x12);            // Unlock OLED driver IC	
	
	cmdWrite(SET_CMD_LOCK);     // Command Lock
	dataWrite(0xB1);            // Command A2, B1, B3, BB, BE accessible
	
	cmdWrite(SLEEP_MODE_ON);    // Sleep mode on
	
	cmdWrite(SET_CLOCK);        // Set Display freq/div
	dataWrite(0xF1);            // divide by 2	
	
	cmdWrite(SET_MUX_RATIO);    // Set Multiplex ratio
	dataWrite(0x7F);            // 127
	
	cmdWrite(SET_DISP_OFFSET);  // Set Display offset
	dataWrite(0x00);            // 0
	
	cmdWrite(SET_DISP_START_LINE);      // Set Display start line
	dataWrite(0x00);           //
			
	cmdWrite(SET_REMAP);        // Set Remap and color depth
	dataWrite(0xb4);            // Horizontal address increment, R->G->B
	
	cmdWrite(SET_GPIO);         // Set GPIO
	dataWrite(0x00);            //
			
	cmdWrite(FUNCTION_SEL);     // Function slelction
	dataWrite(0x01);   //
				
	cmdWrite(SET_SEG_LOW_VOL);      // Set segment low voltage
	dataWrite(0xA0);   				
	dataWrite(0xB5);    
	dataWrite(0x55);   
	
	cmdWrite(SET_CNTRAST_COLOR);        // Set contrast current
	dataWrite(0xC8);   				
	dataWrite(0x80);    
	dataWrite(0xC8);   		
	
	cmdWrite(MASTER_CNTRAST);    // Set Master current control
	dataWrite(0x0F);   
				
	cmdWrite(SET_GRAY_LUT);         // Gamma lookup table	
	    dataWrite(0x2);   //34
	    dataWrite(0x3);   //34
	    dataWrite(0x4);   //34
	    dataWrite(0x5);   //34
	    dataWrite(0x6);   //34
	    dataWrite(0x7);   //34
	    dataWrite(0x8);   //34
	    dataWrite(0x9);   //34
	    dataWrite(0xa);   //34
	    dataWrite(0xb);   //34
	    dataWrite(0xc);   //34
	    dataWrite(0xd);   //34
	    dataWrite(0xe);   //34
	    dataWrite(0xf);   //34
	    dataWrite(0x10);   //34
	    dataWrite(0x11);   //34
	    dataWrite(0x12);   //34
	    dataWrite(0x13);   //34
	    dataWrite(0x15);   //34
	    dataWrite(0x17);   //34
	    dataWrite(0x19);   //34
	    dataWrite(0x1B);   //34
	    dataWrite(0x1D);   //34
	    dataWrite(0x1F);   //34
	    dataWrite(0x21);   //34
	    dataWrite(0x23);   //34
	    dataWrite(0x25);   //34
	    dataWrite(0x27);   //34
	    dataWrite(0x2A);   //34
	    dataWrite(0x2D);   //34
	    dataWrite(0x30);   //34
	    dataWrite(0x33);   //34
	    dataWrite(0x36);   //34
	    dataWrite(0x39);   //34
	    dataWrite(0x3C);   //34
	    dataWrite(0x3F);   //34
	    dataWrite(0x42);   //34
	    dataWrite(0x45);   //34
	    dataWrite(0x48);   //34
	    dataWrite(0x4C);   //34
	    dataWrite(0x50);   //34
	    dataWrite(0x54);   //34
	    dataWrite(0x58);   //34
	    dataWrite(0x5C);   //34
	    dataWrite(0x60);   //34
	    dataWrite(0x64);   //34
	    dataWrite(0x68);   //34
	    dataWrite(0x6C);   //34
	    dataWrite(0x70);   //34
	    dataWrite(0x74);   //34
	    dataWrite(0x78);   //34
	    dataWrite(0x7D);   //34
	    dataWrite(0x82);   //34
	    dataWrite(0x87);   //34
	    dataWrite(0x8C);   //34
        dataWrite(0x91);   //34
	    dataWrite(0x96);   //34
	    dataWrite(0x9B);   //34
	    dataWrite(0xA0);   //34
	    dataWrite(0xA5);   //34
	    dataWrite(0xAA);   //34
	    dataWrite(0xAF);   //34
	    dataWrite(0xB4);   //34


	cmdWrite(SET_PRECHARGE_PERIOD1);    // Set Phase lenth
	dataWrite(0x32);   
			
	cmdWrite(ENHANCE_DRIVE);        // Enhance driving scheme capability
	dataWrite(0xA4);   //				
	dataWrite(0x00);    // 
	dataWrite(0x00);   //				
		
	cmdWrite(SET_PRECHARGE_VOL);    // Set precharge voltage
	dataWrite(0x17);   // 
	
	cmdWrite(SET_PRECHARGE_PERIOD2);    // Set second precharge period	
	dataWrite(0x01);   //			
	
	cmdWrite(SET_VCOM_VOL);    // Set VCOMH voltage
	dataWrite(0x05);   //
	
	cmdWrite(SET_DISP_NORMAL);    // Set Display Mode	
	// clear screen
	cmdWrite(SLEEP_MODE_OFF);    // Set Display Mode	
}

/*--------------------------------------------------------------------------**
** 	Function Name: drawLine                                                 **
** 	Description : 	- The function draw a line between the specified points **
** 	Parameters	:	- cs_flag  - In - 0                                     **
** 					- colstart - In                                         **
** 					- rowstart - In                                         **
** 					- colend   - In                                         **
** 					- rowend   - In                                         **
** 	                                                                        **
**--------------------------------------------------------------------------*/

#if 0
Int32 drawLine(  Uint16 colStart,
               Uint16 rowStart,
               Uint16 colEnd,
               Uint16 rowEnd,
               Uint16 color,
               Uint16 cs_flag )
{ 
    Uint8 tempLSB;
	Uint8 tempMSB;

    if (colStart > DISPLAY_HEIGHT )
      return PSP_E_INVAL_PARAM;
    if (rowStart > DISPLAY_WIDTH )
        return PSP_E_INVAL_PARAM;
    if (colEnd > DISPLAY_HEIGHT )
        return PSP_E_INVAL_PARAM;
    if (rowEnd > DISPLAY_WIDTH )
        return PSP_E_INVAL_PARAM;
    
    cmdWrite(0x83);    
    dataWrite(colStart);
	dataWrite(rowStart);
	dataWrite(colEnd);
	dataWrite(rowEnd);

    tempLSB = (Uint8)color ;
	tempMSB = (Uint8)(color >> 8);
	dataWrite(tempLSB);
    dataWrite(tempMSB);

	return 0;
}
#endif


/*-------------------------------------------------------------------------------**
** 	FunctionName: draw_string                                                    **
** 	Description : 	-   The function draws the string specified in the           **
** 						pData at the specified location, with the color          **
** 						specified and with the font set in font table.           **
** 	                                                                             **
** 	Parameters	:	- cs_flag - In - 0                                           **
** 					  startc - In                                                **
** 					  startl - In                                                **
** 					  pData  - In -  The string to be displayed                  **
** 					  Color - In - The color in which the display has to be done **
**                                                                               **
**-------------------------------------------------------------------------------*/


void draw_string (Uint16 startc, Uint16 startl, char *pData,Uint32 Color)
{
    Uint16 font, i=0;
    
    
	i = strlen(pData);
    if(i > 8)
        return;
        
	i =0;
    while(1)
    {
        font = *(pData+i);
        if(font != 0)
        {
            draw_font(startc+i*7,startl,font,Color);
            i++;
        }
        else
        {
            break;
        }
    }
}

/*----------------------------------------------------------------------------------**
** 	FunctionName : draw_font                                                        **
** 	Description : 	- The function draws a character in the LCD as in the fonttable **
** 	Parameters	:	- cs_flag - In - 0                                              **
** 					  startc - In                                                   **
** 					  startl - In                                                   **
** 					  pData  - In -  The character to be displayed                  **
** 					  Color - In - The color in which the display has to be done    **
**                                                                                  **
**----------------------------------------------------------------------------------*/
	

void draw_font(Uint16 col_address, Uint16 low_address, Uint16 font,Uint32 color)
{
    unsigned char *pFontTable, *pFont, Data;
    Uint16 i,j,bit;    
    Uint16 Red, Green, Blue;
    
    pFontTable = lcdFontTable;
    pFont = pFontTable + (font - ' ')*8; 

    Red = (color&0x003F0000)>>16;
    Green = (color&0x00003F00)>>8;
    Blue = color&0x0000003F;
    
    cmdWrite(SET_COL_ADD);
	dataWrite(col_address);
	dataWrite(col_address+FONT_BITMAP_SIZE-1);        
	wait(10);     

	cmdWrite(SET_ROW_ADD); 
	dataWrite(low_address);
	dataWrite(low_address+FONT_BITMAP_SIZE-1);
	wait(10);

	cmdWrite(WRITE_COMMAND);            // Enable MCU to Write into RAM	 

    
    for(i=0; i<FONT_BITMAP_SIZE; i++)
    {
        Data = *(pFont +i);
        for(j=0; j<FONT_BITMAP_SIZE; j++)
        {
            bit = Data&(0x80>>j);    
            if(bit == 0)
            {
                dataWrite(0);       // R
                dataWrite(0);       // G
                dataWrite(0);       // B
            }
            else
            {
                dataWrite(Red);       
                dataWrite(Green);      
                dataWrite(Blue);       
            }
        }
    }
}



/*--------------------------------------------------------------**
** 	Function Name: LCD_clear_window                             **
** 	Description : 	- The function clears the entire LCD screen **
** 	Parameters	:	- startc - In -                             **
** 					- startl - In -                             **
** 					- endc	 - In -                             **
** 					- endl	 - In -                             **
**--------------------------------------------------------------*/

void LCD_clear_window( Uint16 startc,Uint16 startl, Uint16 endc,Uint16 endl)
{
    Uint16 i, j;
    int width, height;
    
    width = endc - startc;
    //if(width <=0)
    //    return;
    height = endl - startl;
    //if(height <=0)
    //    return;

    LCDLIDDCS0ADDR = SET_COL_ADD;
    LCDLIDDCS0DATA = startc;
    LCDLIDDCS0DATA = endc-1;
    
    LCDLIDDCS0ADDR = SET_ROW_ADD;
    LCDLIDDCS0DATA = startl;
    LCDLIDDCS0DATA = endl-1;
    
    LCDLIDDCS0ADDR = WRITE_COMMAND;
	for(i=0;i<height;i++)
	{
		for(j=0;j<width;j++)
		{
		    LCDLIDDCS0DATA =0;
		    LCDLIDDCS0DATA =0;
		    LCDLIDDCS0DATA =0;
		}
	}		
}

/*-------------------------------------------------------------------------**
**  	Function Name: LCD_hr_status_update                                **
**  	Description - 	Here the variable containing the HR value is split **
**  					into 3 digits and then displayed on LCD            **
**                                                                         **
** 	Parameters  - Nil	                                                   **
**                                                                         **
**-------------------------------------------------------------------------*/

void draw_font_HR(Uint16 startc, Uint16 startl, Uint16 font,Uint32 color)
{
#if 0    
    draw_font(startc,startl,font,color);
#else    
    Uint16 j,bit;
    static Uint16 iHR;
    unsigned char *pData, data;
    Uint16 Red, Green, Blue;
         
    pData = lcdFontTable;

    
    Red = (color&0x003F0000)>>16;
    Green = (color&0x00003F00)>>8;
    Blue = color&0x0000003F;
    
    data = *(pData + (font - ' ')*8  + iHR);         

	cmdWrite(SET_COL_ADD); 
	dataWrite(startc);
	dataWrite(startc+7);
	cmdWrite(SET_ROW_ADD); 
	dataWrite(startl+iHR);
	dataWrite(startl+iHR);
	cmdWrite(WRITE_COMMAND);  

    for(j=0; j<8; j++)
    {
        bit = data&(0x80>>j);
        if(bit == 0)
        {
			LCDLIDDCS0DATA =0;
			LCDLIDDCS0DATA =0;
			LCDLIDDCS0DATA =0;
        }
        else
        {
			LCDLIDDCS0DATA = (Red);
			LCDLIDDCS0DATA = (Green);
			LCDLIDDCS0DATA = (Blue);
        }
    }
    
	iHR++;
	if(iHR>=8)
	{
		iHR = 0;
    }
#endif
    
}
