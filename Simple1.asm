	#include p18f87k22.inc
	
	code
	org 0x0
	goto	setup
	
	org 0x100		    ; Main code starts here at address 0x100

	; ******* Programme FLASH read Setup Code ****  
setup	bcf	EECON1, CFGS	; point to Flash program memory  
	bsf	EECON1, EEPGD 	; access Flash program memory
	goto	start
	; ******* My data and where to put it in RAM *
	
start	lfsr	FSR0, 0x400	; Load FSR0 with address in RAM	
	movlw	0xff		; 22 bytes to read
	movwf 	0x10		; our counter register
	movlw	0x00
	movwf	0x50

loop	movff	0x50, POSTINC0
	incf	0x50, f
	decfsz	0x10		; count down to zero
	bra	loop		; keep going until finished
	
	goto	0

	end
