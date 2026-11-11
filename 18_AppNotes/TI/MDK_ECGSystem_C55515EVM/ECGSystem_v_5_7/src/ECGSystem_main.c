/*****************************************************************************
 * File Name 	: ECGSystem_main.c 
 *
 * Brief   	:                                                           
 *  This file implements the ECG System for 2 Channel Fixed Channel         
 *  aquisition and a display of 6 Leads(1 Lead at a time) in the LCD with   
 *  option to change the leads as well as zooming of the display. 
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

#include "ECGDemoNonBios.h"     
#include "lcd.h"

/* Global ariables used in this file */

/* Acquisition Buffer to store the values read from ADS1258 */
Int32 AqsnBuff[AQSNBUFFSIZE] = {0};
/* Flag which is getting set once the acquisition for all the channels is */
/* done for 1 sec                                                         */ 		 
Uint8 AqsnBuffFullInt;
/* varaible to store the current acquisition channel */
Uint8 CurrAqsnChan;
/* array to store the last one acquisition sample for all channels  */
extern Int32 PrevAqsnVal[];

/* LeadInfo Buffer*/
ECG_Lead_Info Lead_Info;
/* System Information structure*/								
ECG_System_Info ECG_Info;			
/* Leadoffstatus variable*/
Uint16 LeadOffStatus = 0x01FF;	

extern Uint8 FE_Active;
Uint32 Count =0;

/* Handle for UART driver*/
extern PSP_Handle hUart;
/* structure which stores the UART configuration values*/
extern PSP_UartConfig uartCfg;	
Uint16 Initial_HR_Flag = 0;
Uint16 HR_flag = 0;
Uint16 LeadOff_Flag = 0;
Uint16 HR_display_count = 1;	
Uint16 lead_digit_count = 0;
static Uint8 digit1,digit2,digit3;

/*-------------------------------------------------------------------------**
**    Function name : ECG_System()                                         **
**    Description : The main function does the following:-                 **
**                                                                         **
**                     - Call the ADS Read Channel data for one channel    **
**                                                                         **
**                     - Call the fuction to make it to current sample of  **
**                     24 bit                                              **
**                                                                         **
**                     - Call the Process function for the current sample  **
**                                                                         **
**                     - Store it in the LeadInfo buffer                   **
**                                                                         **
**                     - Call the QRS Algorithm                            **
**                                                                         **
**                     - Call the LCD plot function for the current sample **
**                                                                         **
**                 All the above tasks will be done for 1 sec of samples   **
**                 for 2 channels with a sample rate of 173 SPS            **
**                                                                         **
**     Parameters  : None                                                  **
** 	  Return	   : ECG system status                                     **
**-------------------------------------------------------------------------*/

ECG_Status ECG_System()
{
     
      /* Declare all the variables used in the function*/
	ECG_Status Status = ECG_OK; /* Status Variable */
	/* Count variables used for Aquisition */
	static Uint16 CurrAqsnRow = 0,DecimatorCount = 1;
	/* pointer to the Current Aqsn channel */
	Uint8 *CurrChannel;
	/* Array to hold Current Channel data */             
	Uint8 ChannelData[4] = {0};
	/* Count variables used for Filter  */ 
	static Uint32 CurrProcLead = 0,CurrLeadInfoRow = 0;
	/* variable to check the first time of execution*/ 
	static Uint8 FirstFlag = 0;
	/* Counter variable*/
	Uint32 Count1=0;
	/* Count used to check the no of times of execution of the function */  
	static Uint16 TimCount =0;

	
	/* Assign the address for Current Aqsn Channel pointer */
    CurrChannel = &CurrAqsnChan;
	
	/* The  loop does the aquisition, DC removal, Filtering and Display of one */
	/* sample at a time. The loop expires ones the aquisition counter reaches  */
	/* the AQSNBUFFSIZE                                                        */ 
    
    
	/* Get the current channel data from ADS1259 */
    do 
    {
		/* Channel data Read function */     
        ADS1258_Read_ChannelData(ChannelData,CurrChannel);
       	/* check the read data channel with expected channle of data */  
    }while(*CurrChannel != (CurrProcLead));

	/* If ECG samples is going beyond 450 samples then decimation can */
	/* be performed. This is selected by the value of DECIMATOR. If   */
	/* DECIMATOR = 1 no decimation is performed.	                  */
       
	/* check if the decimator count reach
	es the decimate factor */
    if(DecimatorCount == DECIMATOR)
    {
        /* Clear the data to store the current aqsn data */
        AqsnBuff[CurrAqsnRow]= 0;

		/* Get the current channels 24 bit sample from the ADS1258 */
		/* channel data                                            */
		AqsnBuff[CurrAqsnRow] = ((ECG_GetCurrAqsnSample(ChannelData))/ 16);
    	
       	
       	/* Process the current sample so as to remove the DC and filter */
		/* the data                                                     */

       	ECG_ProcessCurrSample(CurrAqsnRow,FirstFlag,CurrProcLead,CurrLeadInfoRow);
#if 1		
		/*  Display the HR in LCD*/
		ECG_LCD_HRDisplay();	
#endif
		/* Display Lead Off Status on LCD*/
#if 1		 
		 if(LeadOff_Flag)
		 ECG_LCD_LeadOffDisplay();	
#endif


		/* Start the QRS and LCD display only after 3 seconds */
		if(TimCount > 4) 
       	{
           
			/* QRS Algorithm is called for every (N/3) samples filled in */
			/* Lead_info Buffer where N- Filter Order	                 */

            if(((CurrLeadInfoRow+1) % (Int16)QRSCALLFACT) == 0)
            {
				/* Call QRS algorithm interface */
           	QRS_Algorithm_Interface(CurrLeadInfoRow) ;
            } 
            
            /* Tx the current sample through UART */
           ECG_UARTTxCurrSamples(CurrLeadInfoRow,CurrProcLead);  
#if 1          
           /* Plot the current processed sample in the LCD */
           ECG_LCDPlotCurrSample(CurrLeadInfoRow,CurrProcLead);     
 
            
#endif

        
        }       
                    
	    /* reset the Filter count values on completing all the leads */        
	    if(CurrProcLead == MAXCHAN-1)       
	    {
	    	CurrProcLead = 0;
	        DecimatorCount = 1;
				
			CurrLeadInfoRow++;/* Else Increment the count*/
				
			/* reset the lead info buffer on completing the LEADINFOSIZE */
	        if(CurrLeadInfoRow == LEADINFOSIZE)
			{
	        	CurrLeadInfoRow = 0;

				/* increment the timer count if less than 5*/
				if(TimCount<10)
			    	TimCount++;
				else
					TimCount = 10;
			}
	            
	                
	     }
	     else
		 {
	     	CurrProcLead++;/* Else increment the count */
		 }

	    CurrAqsnRow++;/* increment the aqsn count*/   

	    }
	    else
	    {
	        DecimatorCount++;/* increment the decimator count*/
	    }

       
    if(CurrAqsnRow == AQSNBUFFSIZE)
    {
	    /* This loop will store the last processed sample of each channel 
	    to be used by the DC removal on next cycle*/

	    for(Count1 = MAXCHAN;Count1 > 0 ; Count1--)
	    PrevAqsnVal[MAXCHAN - Count1] = AqsnBuff[AQSNBUFFSIZE - Count1]; 
		
		/* Set to one after the first seconds execution*/
	    FirstFlag=1;
	    	          
		/* Set the current aquisition row to zero*/
		CurrAqsnRow = 0;

		 /* Clear the Aquisition Buffer */
		
		for(Count=0;Count<AQSNBUFFSIZE;Count++)
		AqsnBuff[Count] = 0;

    } 

    return Status;
}

void ECG_StartTimer0()
{
	/* Start the Timer 0*/
	*CPU_TIM0_CTRL = *CPU_TIM0_CTRL | 0x0001; 
}

/*-------------------------------------------------------------------------**
**     Function Name	: main()                                           **
**     Description 	: The main function does the following:-               **
**                                                                         **
**                     - Clears all the global buffers                     **
**                                                                         **
**                     - Call the C5505 Initialization function            **
**                                                                         **
**                     - Clear the LCD and display the startup screen      **
**                                                                         **
**                     - Call the ECG System function in an infinite while **
**                     loop                                                **
**                                                                         **
**  Parameters  : None	                                                   **
** 	Returns		: void                                                     **
**-------------------------------------------------------------------------*/

extern 	unsigned char UARTPacket[256];

extern	unsigned char UARTstart;
extern	unsigned char UARTend;
extern	unsigned UARTdataRdy;

void main()
{
    ECG_Status Status;				
    //Uint8 UARTVal[1] = 0xA5;
	//PSP_Result retVal = 0;


	/* Call  Initialization function for the ECG system */
    Status = ECG_C5505Init();
    if(Status != ECG_OK)
    {
		//printf("ECG System Initialization FAIL\n");
		while(1);
	}
	else
	{
		//printf("ECG System Initialization PASS\n");
	
	}
    
	wait(1000);

	/* Display the ECG startup screen in LCD */
    ECG_DisplayLCDStartUpScreen();

	/* Start the Timer0*/
	ECG_StartTimer0();

	/* Infinite loop - the ECG processing will be done according to timer*/
	while(1)
	{
 			if ( UARTdataRdy )
			{
				while ( UARTstart != UARTend)
				{
					dda_uartWrite(hUart,&UARTPacket[UARTend], 1, -1, &uartCfg);
					UARTend++;
					if ( UARTstart == UARTend)
					{
						UARTstart =	UARTend = 0;
					}

				}	
				UARTdataRdy = 0;			
			}
	}
    
}
   
void ECG_LCD_HRDisplay(void)	
{

	extern Uint32 QRS_Heart_Rate; 
   	Uint32 HR;
	Uint16 new_val; 
	static Uint16 PrevHr = 0;
	static Uint16 digit1_count = 0;  


	if(HR_flag)
	{
		if(PrevHr != QRS_Heart_Rate)
		{
		if(Initial_HR_Flag)
		{
			HR = QRS_Heart_Rate;
			digit1 = HR/100;
			new_val = HR % 100;
 			digit2 = new_val / 10;
			digit3 = new_val % 10;
			Initial_HR_Flag = 0;
		}
		if(digit1_count<8)
		{	
		//	digit1 = HR/100;				/*getting the first digit of HR value*/
 			draw_font_HR(82,13,(digit1+48),BLUE);/*displaying it by adding ASCII value*/
		}

 		if((digit1_count >= 8)&&(digit1_count <= 15))
		{	
		//	new_val = HR % 100;
 		//	digit2 = new_val / 10;				/*getting the second digit of HR value*/
 			draw_font_HR(90,13,(digit2+48),BLUE);/*displaying it by adding ASCII value*/
		}
		if((digit1_count >15)&&(digit1_count <= 23))
		{							
 		//	digit3 = new_val % 10;				/*getting the third digit of HR value*/
			draw_font_HR(98,13,(digit3+48),BLUE);/*displaying it by adding ASCII value*/
		}
		
		digit1_count++;	
		if(digit1_count >= 24)
			{
			digit1_count = 0;
			HR_flag = 0;	
			PrevHr = QRS_Heart_Rate;	
			}	
		}
	}

}



void ECG_LCD_LeadOffDisplay(void)	
{
	if(LeadOffStatus != 0x01FF)
 		{
			if(LeadOffStatus == ELECTRODE_RA)
				{
					/*Electrode  RA is OFF*/
					if(lead_digit_count<8)
					{
						draw_font_HR(45,13,82,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,65,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}
				}
			else if(LeadOffStatus == ELECTRODE_LA)
				{
					/*Electrode  LA is OFF*/
					if(lead_digit_count<8)
					{
						draw_font_HR(45,13,76,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,65,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}
				}
			else if(LeadOffStatus == ELECTRODE_LL)
				{
					/*Electrode  LL is OFF*/
				if(lead_digit_count<8)
					{
						draw_font_HR(45,13,76,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,76,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}	
				}
			
			else if(LeadOffStatus == ELECTRODE_V1)
				{
					/*Electrode  V1 is OFF*/
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,86,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,49,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}	
				}
			else if(LeadOffStatus == ELECTRODE_V2)
				{
					/*Electrode  V2 is OFF*/
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,86,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,50,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}		
				}
			else if(LeadOffStatus == ELECTRODE_V3)
				{
					/*Electrode  V3 is OFF*/
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,86,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,51,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}	
				}
			else if(LeadOffStatus == ELECTRODE_V4)
				{
					/*Electrode  V4 is OFF*/
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,86,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,52,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}		
				}
			else if(LeadOffStatus == ELECTRODE_V5)
				{
					/*Electrode  V5 is OFF*/
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,86,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,53,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
}
					}	
				}
			else if(LeadOffStatus == ELECTRODE_V6)
				{
					/*Electrode  V6 is OFF*/
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,86,RED);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						draw_font_HR(53,13,54,RED);
						lead_digit_count++;
						if(lead_digit_count >= 16)
						{
							lead_digit_count = 0;
							LeadOff_Flag = 0;
						}
					}	
				}
			

			else 
				/*Red circle indicating 2 or more leads are off*/
				{
					if(lead_digit_count < 8)
					{
						draw_font_HR(45,13,38,RED);
						LCD_clear_window(53,13,61,21);
						lead_digit_count++;
					}
					if(lead_digit_count >= 8)
					{
						lead_digit_count = 0;
						LeadOff_Flag = 0;
					}
				}	
 		}
	else
		/*Green circle indicating all the leads are connected*/
		{
			//LCD_clear_window(45,13,60,20);
			if(lead_digit_count < 8)
			{
				draw_font_HR(45,13,38,GREEN);
				LCD_clear_window(53,13,61,21);
				lead_digit_count++;
			}
			if(lead_digit_count >= 8)
			{
				lead_digit_count = 0;
				LeadOff_Flag = 0;
			}
		}
}
