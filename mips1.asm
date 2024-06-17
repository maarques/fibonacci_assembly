.data
    msg_fib: .asciiz "O trig�simo n�meor da sequ�ncia de fibonacci �: "
    msg_phi: .asciiz "A propor��o �urea (phi) �: "
    newline: .asciiz "\n"

.text

main:
    # Calcular o 30� n�mero de Fibonacci
    li $a0, 30          # Coloca 30 em $a0 (argumento da fun��o)
    jal fibonacci       # Chama a fun��o fibonacci
    move $s1, $v0       # Armazena o resultado (30� Fibonacci) em $s1

    # Exibir mensagem para o 30� Fibonacci
    li $v0, 4           # C�digo de servi�o para imprimir string
    la $a0, msg_fib     # Carrega o endere�o da mensagem
    syscall             # Chama o sistema para imprimir a mensagem

    # Exibir o 30� Fibonacci
    li $v0, 1           # C�digo de servi�o para imprimir inteiro
    move $a0, $s1       # Carrega o valor de Fibonacci em $a0
    syscall             # Chama o sistema para imprimir o valor

    # Exibir quebra de linha
    li $v0, 4           # C�digo de servi�o para imprimir string
    la $a0, newline     # Carrega o endere�o da quebra de linha
    syscall             # Chama o sistema para imprimir a quebra de linha

    # Calcular o 41� n�mero de Fibonacci
    li $a0, 41          # Coloca 41 em $a0 (argumento da fun��o)
    jal fibonacci       # Chama a fun��o fibonacci
    move $s2, $v0       # Armazena o resultado (41� Fibonacci) em $s2

    # Calcular o 40� n�mero de Fibonacci
    li $a0, 40          # Coloca 40 em $a0 (argumento da fun��o)
    jal fibonacci       # Chama a fun��o fibonacci
    move $s3, $v0       # Armazena o resultado (40� Fibonacci) em $s3

    # Calcular a Raz�o �urea (?) usando F41 e F40
    move $t0, $s2       # Move F41 (41� Fibonacci) para $t0
    move $t1, $s3       # Move F40 (40� Fibonacci) para $t1
    mtc1 $t0, $f2       # Move F41 para o registrador de ponto flutuante $f2
    mtc1 $t1, $f4       # Move F40 para o registrador de ponto flutuante $f4
    cvt.s.w $f2, $f2    # Converte F41 para ponto flutuante
    cvt.s.w $f4, $f4    # Converte F40 para ponto flutuante
    div.s $f0, $f2, $f4 # Calcula ? = F41 / F40 e armazena em $f0

    # Exibir mensagem para a Raz�o �urea
    li $v0, 4           # C�digo de servi�o para imprimir string
    la $a0, msg_phi     # Carrega o endere�o da mensagem
    syscall             # Chama o sistema para imprimir a mensagem

    # Exibir a Raz�o �urea
    li $v0, 2           # C�digo de servi�o para imprimir ponto flutuante
    mov.s $f12, $f0     # Carrega o valor de ? em $f12
    syscall             # Chama o sistema para imprimir o valor

    # Termina o programa
    li $v0, 10          # C�digo de servi�o para sa�da
    syscall             # Chama o sistema para sair

# Fun��o para calcular o m-�simo n�mero de Fibonacci
fibonacci:
    li $t0, 0          # F(0) = 0
    li $t1, 1          # F(1) = 1
    li $t2, 2          # Contador = 2

    # Se m < 2, retorna m
    blt $a0, $t2, fib_end

fib_loop:
    add $t3, $t0, $t1  # fib = F(n-1) + F(n-2)
    move $t0, $t1      # F(n-2) = F(n-1)
    move $t1, $t3      # F(n-1) = fib
    addi $t2, $t2, 1   # contador += 1
    bne $t2, $a0, fib_loop # Se contador != m, repete o loop

fib_end:
    move $v0, $t1      # Coloca o resultado (fib) em $v0
    jr $ra             # Retorna � fun��o chamadora