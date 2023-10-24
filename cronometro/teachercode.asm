SW EQU P2.0
LED EQU P1.0

A0 EQU P3.3
A1 EQU P3.4

CS EQU P0.7 

; A1 A0
; 0 0 - D0
; 0 1 - D1
; 1 0 - D2
; 1 1 - D3
; SETB - Seta o bit em 1
; CLR - Seta o bit em 0

CLR A0 ;Seletor de display
CLR A1

CLR CS

;CLR P0.7

MOV P1, #10100100b



main:
JB SW, apagar
JNB SW,blink
blink:
	CLR LED
	ACALL delay
	SETB LED
	ACALL delay
	JMP main

apagar:
	SETB LED
	JMP main

delay:
	MOV R1, #100
	inicio:
		MOV R0, #250
		DJNZ R0, $
		DJNZ R1,inicio
RET