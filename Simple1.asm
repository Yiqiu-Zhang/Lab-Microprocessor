	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100

start	
	movlw 	0xff
	movwf	TRISD, ACCESS	    ; Port D all INputs
	movlw	0x00
	movwf	TRISC, ACCESS	    ; Port C all outputs
	bra 	test
loop	movff 	0x06, PORTC
	movlw	0xff
	movwf	0x20,	ACCESS	    ;Address which stores the cycle that delayed	
	call	delay
	incf 	0x06, W, ACCESS
	
test	movwf	0x06, ACCESS	    ; Test for end of loop condition
	movf	PORTD, W, ACCESS    ; Assign VALUE OF PORTD TO W
	cpfsgt 	0x06, ACCESS
	bra 	loop		    ; Not yet finished goto start of loop again
	goto 	0x0		    ; Re-run program from start

delay	decfsz	0x20, F, ACCESS
	bra delay
	return
	
	end
