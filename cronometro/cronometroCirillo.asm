SW1 Equ P2.0
SW2 Equ P2.1

CS EQU P0.7
A0 EQU P3.3
A1 EQU P3.4

		Org 00h
Select:	SetB CS   	;Chip select
		SetB A0   	;Select Disp
		SetB A1		;Select Disp	

Start:
		Jnb SW1, Init				;caso SW1 pressionado (low) inicializa o programa
		Jnb SW2, Init				;caso SW2 pressionado (low) inicializa o programa
		Sjmp Start					;volta para o start esperando SW1 ou SW2 ser pressionado

Init:		Mov R3,#00Ah			;inicializador do loop para rodar o programa 10(0Ah) vezes
Main:		Mov DPTR,#LUT			;traz a lookup table para o DPTR
Back:		Clr A					;limpa o valor de A e estabelece o ponto de retorno do loop 0 a 9
			Movc A,@A+DPTR			;insere DPTR com um offset de A em A
			Mov P1,A				;mostra A no display selecionado
			Jnb SW1, Delay_250ms	;caso SW1 pressionado (low) faz o delay de 250ms
			Jnb SW2, Delay_1000ms	;caso SW2 pressionado (low) faz o delay de 1000ms
Number_inc:	Inc DPTR				;proximo valor da tabela de procura e ponto de retorno dos delays
									;com esse ponto de retorno caso SW1 e SW2 estejam pressionados o delay não sera 1250ms
			Djnz R3,Back			;decrementa nosso loop de rodar o programa em 10 vezes e retorna para back

			Sjmp Init				;caso ele passe do decremento e retorno do loop retorna para init e reinicia a contagem

Delay_250ms:
			Mov R7, #01				;coloca 1 em R7 para que o loop de delay seja realizado apenas 1x
			Jmp Delay				;vai para a função de delay

Delay_1000ms:					
			Mov R7, #04				;coloca 4 em R7 para que o loop de delay seja realizado 4x
			Jmp Delay				;vai para a função de relay

Delay:		Mov	R0, #200			;loop geral (1x para 250ms e 4x para 1000ms)
Again: 		Mov	R1, #230			;loop externo (reinicia o loop interno)
Here:  		Nop						;loop interno
			Nop
			Djnz R1, Here   		;continua o loop interno enquanto R1 não for 0
			Djnz R0, Again  		;continua o loop externo enquanto R0 não for 0
			Djnz R7, Delay			;continua o loop geral enquanto R7 não for 0
			Jmp Number_inc			;retorna do delay para o ponto de incremento 
			;!talvez remover ret e trazer um jmp direto pra ca e trocar o acall?

;calculo de loop:
	;no loop interno temos 1 + 1 + 2 ciclos de máquina rodando 200 vezes, cada ciclo tem 1.085us com 11.0592MHz
		;loop interno = 1247.75us
	;o loop externo faz com que o loop interno rode 200 vezes
		;loop externo = 249550us = 249.55ms
	;o overhead do loop externo 1 + 2 ciclos de maquina rodando 200 vezes
		;overhead do loop externo = 651us
	;o loop geral também tem um overhead para cada delay:
		;250ms -> 1 + 2 ciclos de máquina rodando 1 vez
			;overhead do loop geral 250ms = 3.255us
		;1000ms -> 1 + 2 ciclos de máquina rodando 4 vezes
			;overhead do loop geral 1000ms = 13.02us
	;logo, para 250ms teremos um tempo total de 250204.255us = 250.20ms
	;e para 1000ms teremos um tempo total de 1000856.08us = 1000.86ms
			
			Org 0200h
LUT:    	DB 0C0h, 0F9h, 0A4h, 0B0h, 99h, 92h, 82h, 0F8h, 80h, 90h, 0	
									;lookup table com os codigos para mostrar os digitos em 7 segmentos
	
End