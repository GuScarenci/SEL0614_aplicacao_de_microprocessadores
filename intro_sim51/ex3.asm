	org	0000h
main:
	MOV A, #11001010b	;Move o valor CA para o registrador A
	MOV B, #00110110b	;Move o valor 36 para o registrador B
	RR A				;Rotaciona a para a direita uma vez
	RR A				;Rotaciona a para a direita uma vez
	CPL A				;Realiza o complemento de A
	RL A				;Rotaciona a para a esquerda uma vez
	RL A				;Rotaciona a para a esquerda uma vez
	ORL A, B			;Realiza bitwise OR entre A e B
	XRL A, B			;Realiza bitwise XOR entre A e B
	SWAP A				;Inverte os bits de A
	JMP main			;Volta para o inicio do programa

	end					;Finaliza o programa
	