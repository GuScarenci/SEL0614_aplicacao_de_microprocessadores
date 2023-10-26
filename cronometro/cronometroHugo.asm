ORG 00H

; Definição de constantes
SW0 EQU P3.2  ; Botão/chave 1 (SW0)
SW1 EQU P3.3  ; Botão/chave 2 (SW1)
DISPLAY EQU P1  ; Registrador para controlar o display de 7 segmentos

; Definição de variáveis
DELAY_COUNT EQU 20  ; Valor para controlar o atraso de 0,25s
DELAY_COUNT_FAST EQU 80  ; Valor para controlar o atraso de 1s
COUNTER EQU R0  ; Variável de contagem
DELAY EQU R1  ; Variável de atraso

MAIN:
    MOV COUNTER, #0   ; Inicializa a variável de contagem
    CLR DISPLAY   ; Desliga o display
    CLR C  ; Limpa a flag de carry

LOOP:
    JB SW0, START_COUNT  ; Se SW0 estiver pressionado, comece a contagem
    JB SW1, FAST_DELAY  ; Se SW1 estiver pressionado, use o atraso rápido
    ACALL DELAY   ; Atraso de 0,25s
    SJMP LOOP

START_COUNT:
    MOV A, COUNTER   ; Move o valor de COUNTER para A
    MOV DISPLAY, A   ; Exibe o valor no display de 7 segmentos
    INC COUNTER   ; Incrementa a contagem
    CJNE A, #9, CONTINUE_COUNT   ; Se A não for igual a 9, continue a contagem
    CLR COUNTER   ; Zere a contagem
    SETB C   ; Defina a flag de carry (indica que a contagem atingiu 9)
CONTINUE_COUNT:
    ACALL DELAY   ; Atraso de 0,25s
    JB C, START_COUNT   ; Se a flag de carry estiver definida, retorne a START_COUNT para reiniciar a contagem
    SJMP LOOP

FAST_DELAY:
    ACALL DELAY_FAST   ; Atraso de 1s
    SJMP LOOP

DELAY:
    MOV DELAY, #DELAY_COUNT
DELAY_LOOP:
    DJNZ DELAY, DELAY_LOOP
    RET

DELAY_FAST:
    MOV DELAY, #DELAY_COUNT_FAST
FAST_DELAY_LOOP:
    DJNZ DELAY, FAST_DELAY_LOOP
    RET

END