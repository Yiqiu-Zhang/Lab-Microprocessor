	#include p18f87k22.inc
	
	code
	org 0x0
	goto	start
	
	org 0x100		    ; Main code starts here at address 0x100	
	; ******* My data and where to put it in RAM *
	
start	
	
	constant    myprotC = 0x20
	constant    myprotD = 0x30
	constant    myprotE = 0x40
	constant    myprotH = 0x41
	constant    mydelay = 0x50
	constant    mydelay1 = 0x60
	movlw	0x00
	movwf	TRISD, ACCESS	; set RD0,1,2,3 as output
	
	movlw	0x0f		
	movwf	myprotD, ACCESS	
	movff	myprotD, PORTD	; Set all control line high
	
	setf	TRISE		; Tri-state PortE	 	
	banksel PADCFG1		; PADCFG1 is not in Access Bank!!
	bsf	PADCFG1, REPU, BANKED	; PortE pull-ups on 
	movlb	0x00		; set BSR back to Bank 0
	
	clrf	TRISE		; Set PROTE as output
	
	movlw	0x04
	movwf	myprotE, ACCESS	;Put data on PROT E
	movff	myprotE, PORTE	
	
	movlw	0x0b		
	movwf	myprotD, ACCESS	; Set CP1* low
	movff	myprotD, PORTD
	
	movlw	0x10
	movwf	mydelay1, ACCESS
	call	delay1		;Call a dealy 

	movlw	0x0f		
	movwf	myprotD, ACCESS	; Raise CP1* 
	movff	myprotD, PORTD
	
	movlw	0x06
	movwf	myprotE, ACCESS	;Put data on PROT E again*
	movff	myprotE, PORTE	
	
	movlw	0x07		
	movwf	myprotD, ACCESS	; Set CP2* low
	movff	myprotD, PORTD
	
	movlw	0x10
	movwf	mydelay1, ACCESS
	call	delay1		;Call a dealy 

	movlw	0x0f		
	movwf	myprotD, ACCESS	; Raise CP2* 
	movff	myprotD, PORTD
	
	setf	TRISE	
	
	movlw	0x0e
	movwf	myprotD, ACCESS	;Set OE1* low
	movff	myprotD, PORTD
	
	movlw	0x10
	movwf	mydelay1, ACCESS
	call	delay1		;Call a dealy 
	
	movlw	0x00
	movwf	TRISC, ACCESS	; set PROTC as output, Wtire POROTE to PORT C
	movf	PORTE, W    
	movwf	myprotC, ACCESS	
	movff	myprotC, PORTC
	
	movlw	0x0f		
	movwf	myprotD, ACCESS	; Set OE1* High 
	movff	myprotD, PORTD
	
	movlw	0x0d
	movwf	myprotD, ACCESS	;Set OE2* low
	movff	myprotD, PORTD
	
	movlw	0x10
	movwf	mydelay1, ACCESS
	call	delay1		;Call a dealy 
	
	movlw	0x00
	movwf	TRISH, ACCESS	; set PortH as output, Wtire POROTE to PORT G
	movf	PORTE, W    
	movwf	myprotH, ACCESS	
	movff	myprotH, PORTH
	
	movlw	0x0f		
	movwf	myprotD, ACCESS	; Set OE2* High 
	movff	myprotD, PORTD
	
	goto	0
	
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
