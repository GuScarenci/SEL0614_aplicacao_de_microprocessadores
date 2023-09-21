org 00h ;Origem em 00h
start: ;Label Inicio
MOV A,	#2	;Move 2 para ACC
MOV	B,	#3	;Move 3 para B
MOV	R0,	#7	; Move 7 para memória qualquer (R0 escolhido)
ADD	A,	R0	;Adciona o valor de R0 em ACC
SUBB	A,	#3	; Subtrai 3 de ACC
INC	B	; Incrementar B em 1
SUBB	A,	B	; Subtrai B de ACC
MUL	AB	; Multiplica A por B
INC	B	; Incrementar B em 1
INC B ; Incrementar B em 1 novamente
DIV	AB	; Dividir A por B
MOV	R1,	A	;Armazena A em R1
MOV	R2,	B	;Armazena B em R2
JMP	start	;Vai para o início
END	;Fim
