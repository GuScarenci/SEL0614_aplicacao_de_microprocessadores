ORG 00h ;Colocar a origem no endereço 00h
JMP main ;Saltar para a label do programa principal (main)
ORG 33h ;Colocar a origem em 33h

main: ;Inicializar o programa principal
CLR A ;Limpar o ACC
MOV R0, #55h ;Mover de forma imediata um valor qualquer para R0

block1: ;Inicializar o bloco 1
JZ block2 ;Saltar SE A = 0 para um o bloco 2
JNZ block3 ;Saltar SE A != 0 para um o bloco 3
NOP ;Consumir tempo de 1us sem fazer mais nada
	 
block2: ;Inicializar o bloco 2
MOV A, R0 ;Mover R0 para A      
JMP block1 ;Saltar para bloco 1

block3: ;Inicializar o bloco 3
DJNZ R0, block3 ;Decrescer em 1 o registrador R0 e pular para bloco 3 se ele não for igual a 0
JMP main ;Saltar para o bloco principal  

END ;Fim
