	org	0000h
main:
	MOV	A,#0CAh			;Move o valor CA para o registrador ACC (1us)
	MOV	A,#00h			;Move o valor 00 para o registrador ACC (1us)

	MOV	PSW, #00000000b	;Altera para o banco de registradores 0 (2us)
	MOV	R0,#0FEh		;Move o valor FE para o registrador R0 (1us)
	MOV	B,#0Bh			;Move o valor B para o registrador B (2us)

	MOV 021H, P1		;Move o valor da porta 1 para o endereço 21 (2us)
	MOV PSW, #00001000b	;Altera para o banco de registradores 1 (2us)
	MOV	R0, 021h		;Move o valor do endereço 21 para o registrador 0 (2us)
	MOV 022h, R0		;Move o valor que está em R0 para o endereço 22 (2us)
	MOV R1, #021h		;Move o valor 21 para o registrador 1 (1us)
	MOV A, @R1			;Move o valor que está no endereço marcado por R1 para o registrador A (1us)

	MOV	DPTR, #09A5Bh	;Move o valor 9A5B para o registrador DPTR (2us)
	NOP					;no operation, delay de um ciclo de máquina (1us)

	end					;finaliza o programa

;a) 20us no total
;b) Um ciclo de máquina do 8051 tem 12 pulsos de clock, como o processador está rodando a 12Mhz, portanto um pulso dura 8,33*10^(-8)s. Um ciclo dura 12 vezes isso = 1us e como o código levou 20us, ele tem 20 ciclos de máquina.
;c) As portas do micro têm um circuito de pullup, por isso naturalmente elas tem valor lógico alto
;d) O valor que estava no endereço marcado por R1
;e) O registrador DPTR é a junção de dois registradores de 8 bits (DPH e DPL), portanto o registrador DPTR é um registrador virtual formado por 2 registradores reais, o que permite a ele armazenar mais de um byte. O maior valor que pode ser movido é FFFF
