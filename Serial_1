	#include p18f87k22.inc
	
	code
	org 0x0
	call	SPI_MasterInit
	goto	SPI_MasterTransmit
	
	org 0x100		    ; Main code starts here at address 0x100	
	; ******* My data and where to put it in RAM *
	
SPI_MasterTransmit  ; Start transmission of data (held in W)
	movlw	0x53
	movwf 	SSP2BUF 
	
	call Wait_Transmit

	movlw	0xff
	movwf	mydelay
	call delay
	
	goto	0
	
Wait_Transmit	; Wait for transmission to complete 
	btfss 	PIR2, SSP2IF
	bra 	Wait_Transmit
	bcf 	PIR2, SSP2IF	; clear interrupt flag
	return		
	
SPI_MasterInit	; Set Clock edge to negative
	constant    mydelay = 0x50
	constant    mydelay1 = 0x60
	bcf	SSP2STAT, CKE
	; MSSP enable; CKP=1; SPI master, clock=Fosc/64 (1MHz)
	movlw 	(1<<SSPEN)|(1<<CKP)|(0x02)
	movwf 	SSP2CON1
	; SDO2 output; SCK2 output
	bcf	TRISD, SDO2
	bcf	TRISD, SCK2
	return 

delay	decfsz	mydelay, F, ACCESS
	movlw	0xff
	movwf	mydelay1
	call	delay1		; anather dealy loop
	bra	delay
	return

delay1	decfsz	mydelay1, F, ACCESS
	bra	delay1
	return

	end
