;******************************************************************************
; * File Name : vectors.asm
; *
; * Brief	 : Interrupt vector
; *
; * Copyright (C) 2009 -2010 Texas Instruments Incorporated - http://www.ti.com/ 
; * 
; * 
; *  Redistribution and use in source and binary forms, with or without 
; *  modification, are permitted provided that the following conditions 
; *  are met:
; *
; *    Redistributions of source code must retain the above copyright 
; *    notice, this list of conditions and the following disclaimer.
; *
; *    Redistributions in binary form must reproduce the above copyright
; *    notice, this list of conditions and the following disclaimer in the 
; *    documentation and/or other materials provided with the   
; *    distribution.
; *
; *    Neither the name of Texas Instruments Incorporated nor the names of
; *    its contributors may be used to endorse or promote products derived
; *    from this software without specific prior written permission.
; *
; *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
; *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
; *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
; *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
; *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
; *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
; *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
; *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
; *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
; *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
; *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
; *
;******************************************************************************/


         .mmregs
         .include "lpva200.inc"
         
         
         .C54CM_off
         .CPL_off
         .ARMS_off
   
;**********************************************************************************
;        predefined stack operation modes  
;**********************************************************************************
;        USE_RETA     : 2x16-bit fast return mode (RETA used)
;        NO_RETA      : 2x16-bit slow return mode (RETA not used)
;        C54X_STK     : 32-bit fast return mode 

;**********************************************************************************    
;		.ref _lcd_isr
;		.ref _DLOGINT_isr
;        .def RST    
         ;.def _spi_isr
;         .ref _spiBus_isr   
         
;**********************************************************************************
        .sect "vectors"
        .align  256         
;**********************************************************************************

;****************************************************************************
;* Other interrupt vector definitions go here
;****************************************************************************
	.def	RST
RST:		.ivec    reset_isr, USE_RETA; Reset / Software Interrupt #0

NMI:		.ivec    nmi_isr				; Nonmaskable Interrupt

INT0:		.ivec    int0_isr				; External User Interrupt #0 

INT1:		.ivec    int1_isr				; External User Interrupt #1

TINT0:		.ivec    tim0_isr				; Timer #0 / Software Interrupt #4

PROG0:		.ivec    i2s0_tx_isr			; Programmable 0 Interrupt

UART:		.ivec    uart_isr				; IIS #1 Receive Interrupt

PROG1:		.ivec    i2s0_rx_isr				; Programmable 1 Interrupt

DMA:		.ivec    dma_isr                ; DMA Interrupt

PROG2:		.ivec    i2s1_tx_isr			; Programmable 2 Interrupt

COPROCFFT:  .ivec    coprocfft_isr			; Coprocessor FFT Module Interrupt

PROG3:		.ivec    i2s1_rx_isr			; Programmable 3 Interrupt

LCD:		.ivec	 lcd_isr				; LCD Interrupt

SARADC:		.ivec    saradc_isr				; SAR ADC Interrupt

XMIT2:		.ivec	 i2s2_tx_isr		    ; I2S2 Tx Interrupt

RCV2:		.ivec	 i2s2_rx_isr		    ; I2S2 Rx Interrupt

XMIT3:		.ivec	 i2s3_tx_isr		    ; I2S3 Tx Interrupt

RCV3:		.ivec	 i2s3_rx_isr		    ; I2S3 Rx Interrupt

RTC:		.ivec    rtc_isr				; RTC interrupt

SPI:    	.ivec    spi_isr				; SPI Receive Interrupt

USB:		.ivec    usb_isr				; USB Transmit Interrupt

GPIO:		.ivec    gpio_isr				; GPIO Interrupt

DMA1CH3:	.ivec    dma1ch3_isr			; DMA1 CH1 Interrupt

I2C:		.ivec    i2c_isr				; IIC interrupt

BERRIV:
IV24:		.ivec	 no_isr   ; Bus error interrupt

;    .ref  _DLOGINT_isr 
DLOGIV:
IV25:		.ivec dlog_isr  ; Data log (RTDX) interrupt

;	.ref _RTOSINT_isr
RTOSIV:
IV26:		.ivec dlog_isr  ; Real-time OS interrupt
IV27:		.ivec rtdxrcv_isr  ; General-purpose software-only interrupt
IV28:		.ivec rtdxxmt_isr  ; General-purpose software-only interrupt
IV29:		.ivec emuint_isr  ; General-purpose software-only interrupt
IV30:		.ivec sint30_isr  ; General-purpose software-only interrupt
IV31:		.ivec sint31_isr  ; General-purpose software-only interrupt



		.text
		.def reset_isr
		.ref _c_int00
		.ref _saradc_isr
		.ref _tim0_isr
		.ref _int1_isr
reset_isr:
	;	*port(#0x1C01) = #0x0				; Clear idles
 		bit (ST1, #11) = #1					; Disable interrupts
    	@IVPD_L = #(RST >> 8) || mmap()
    	@IVPH_L = #(RST >> 8) || mmap()
	   	 bit(ST3,#7) = #0		; Clear bus error interrupts
	   	 ;bit(ST3,#2) = #1		; shut off clockout port

		@#IFR0_L = #0xffff || mmap() ; clear all pending interrupts
		@#IFR1_L = #0xffff || mmap()

;**********************************************************************************
;     Reset all peripherals
;**********************************************************************************
	*port(#0x1C04) = 0x1
	nop_16
	*port(#0x1C05) = 0x00FF	; Reset all peripherals
	nop_16

;**********************************************************************************
;     Set PLL for 100MHz
;**********************************************************************************
    *port(IDLE_PCGCR) = 0x0
    *port(IDLE_PCGCR_MSW) = 0x0

    ; bypass PLL
    *port(CONFIG_MSW) = 0x0

    *port(PLL_CNTL2) = 0x8000
    *port(PLL_CNTL4) = 0x0000
    *port(PLL_CNTL3) = 0x0806
    *port(PLL_CNTL1) = 0x8BE8

wait_pll:
    AC0 = *port(PLL_CNTL3)
    AC0 = AC0 & 0x0008
    if(AC0 == 0) goto wait_pll


    ;;while ( ((*(short *)PLL_CNTL3@IO) & 8) == 0) ;

    *port(CONFIG_MSW) = 0x1

	goto	_c_int00
	

nmi_isr:		goto	nmi_isr

int0_isr:		goto	int0_isr

int1_isr:		goto	_int1_isr

tim0_isr:		goto	_tim0_isr
	
i2s0_tx_isr:	goto	i2s0_tx_isr

uart_isr:		goto	uart_isr

i2s0_rx_isr:	goto	i2s0_rx_isr

dma_isr:		goto	dma_isr

i2s1_tx_isr:	goto	i2s1_tx_isr

coprocfft_isr:	goto	coprocfft_isr

i2s1_rx_isr:	goto	i2s1_rx_isr

lcd_isr:		goto	lcd_isr

saradc_isr:		goto	_saradc_isr
;saradc_isr:		goto	saradc_isr

i2s2_tx_isr:	goto	i2s2_tx_isr

i2s2_rx_isr:	goto	i2s2_rx_isr

i2s3_tx_isr:	goto	i2s3_tx_isr

i2s3_rx_isr:	goto	i2s3_rx_isr

rtc_isr:		goto	rtc_isr

spi_isr:		goto	spi_isr
;spi_isr:		goto    _spiBus_isr

usb_isr:		goto	usb_isr

gpio_isr:		goto	gpio_isr

dma1ch3_isr:	goto    dma1ch3_isr

i2c_isr:		goto    i2c_isr

berr_isr:		
				bit(ST3,#7) = #0		; Clear bus error interrupts
				goto	berr_isr

dlog_isr:		goto	dlog_isr

rtos_isr:		goto	rtos_isr

rtdxrcv_isr:	goto	rtdxrcv_isr 

rtdxxmt_isr:	goto	rtdxxmt_isr

emuint_isr:		goto	emuint_isr

sint30_isr:		goto	sint30_isr

sint31_isr:		goto	sint31_isr 

             .text   
  

********************************************************************************
** Name     : no_isr                                                          **
**                                                                            **
** Purpose  : Spurious interrupt handler                                      **
**                                                                            **
** Author   :                                                                 **
**                                                                            **
********************************************************************************
no_isr:      goto no_isr 

;
_spi_isr:
;        call _spiBus_isr
;    ;bit(ST1,#11) = #1		        ; Disable interrupts
;	;@#IFR1_L = #0x0008||mmap()      ; clear int flag
;
;	;AC0 = *port(#SPI_STAT1)			; read status1 reg
;	;AC1 = *port(#SPI_STAT2)	        ; read word cnt reg
;	    
;	;AC0 = *port(#SPI_DAT1)			; read data1 reg
;	;AC1 = *port(#SPI_DAT2)          ; read data2 reg
;
;    
;    ;bit(ST1,#11) = #0		        ; Enable interrupts
;    
;	; set start CMD - Read 
;	;*port(#SPI_CMD2)= #0x00FA
;	        
        return_int
    .end
    

