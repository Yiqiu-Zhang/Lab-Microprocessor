	#include p18f87k22.inc
	
	code
	org 0x0
	goto	setup
	
	org 0x100		    ; Main code starts here at address 0x100

	; ******* Programme FLASH read Setup Code ****  
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	constant myarray = 0x400 
	constant counter = 0x10
	constant number = 0x50
	constant myread = 0x500
	;constant
	goto	start
	; ******* My data and where to put it in RAM *
	
start	lfsr	FSR0, myarray	; Load FSR0 with address in RAM	
	lfsr	FSR1, myread
	movlw	0x00
	movwf	TRISC, ACCESS
	movlw	0xf1		; 22 bytes to read
	movwf 	counter		; our counter register
	movlw	0x00
	movwf	number

loop	movff	number, INDF0
	movff	INDF0, INDF1
	movf	POSTINC0, w
	cpfseq	POSTINC1, ACCESS
	call	wrong
	incf	number, f
	decfsz	counter		; count down to zero
	bra	loop		; keep going until finished
	
	goto	0
wrong	movff	0x06, PORTC
	movlw	0x05
	movwf	0x06, ACCESS
	return
	end
