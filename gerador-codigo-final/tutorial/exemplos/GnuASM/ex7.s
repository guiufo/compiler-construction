	.file	"ex7.c"
	.comm	a,4,4 # aloca espaço na seção data: nome,tamanho em bytes,alinhamento
	.comm	b,4,4
	.comm	soma,4,4
	.text
	.globl	somador  # declara que o símbolo "somador" é global em escopo, sem defini-lo
	.type	somador, @function # declara que o símbolo "somador" é uma função

	# De acordo com a AMD64 ABI os primeiros 6 argumentos inteiros para uma 
	# função são passados em registradores, na seguinte ordem: rdi, rsi, rdx, 
	# rcs, r8 e r9. Os argumentos que excederem esse número são passados na pilha.
	# Lembrando que registradores começando com r guardam 64 bits e com e, 32. 
	# Como int é de 32 bits, precisamos apenas da metade de rdi, ou seja, edi e
	# assim por diante.
	# O quadro de pilha (stack frame) da função somador fica organizado assim:
	#
	#
	#    endereço alto  |                     |               Registradores
	#                   |                     |
	#                   |                     |               EDI: x
	#                   |                     |               ESI: y 
	#          RBP + 8  | endereço de retorno |               EDX: z 
	#          RBP      | RBP anterior salvo  | <-- RBP
	#          RBP - 4  |         m           |
	#          RBP - 8  |         r           | <-- RSP
	#          RBP - 12 |                     |
	#          RBP - 16 |                     |
	#          RBP - 20 |         x           |
	#          RBP - 24 |         y           |
	#          RBP - 28 |         z           |
    #                   |                     |	
    #                   |                     |	
    #                   |                     |	
	#    endereço baixo |                     |
	# 
somador:
	pushq	%rbp             # salva o ponteiro da base (base pointer) na pilha
	movq	%rsp, %rbp       # o novo ponteiro da base
	# move os 3 argumentos de somador para a pilha
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	$3, -8(%rbp)      # r = 3
	movl	$1, -4(%rbp)      # m = 1
	movl	-20(%rbp), %edx   # EDX = x
	movl	-24(%rbp), %eax   # EAX = y
	addl	%eax, %edx        # EDX = x + y 
	movl	-28(%rbp), %eax   # EAX = z
	addl	%edx, %eax        # EAX = x + y + z
	imull	-4(%rbp), %eax    # EAX = m * (x + y + z)
	movl	%eax, -8(%rbp)    # r = EAX
	movl	-8(%rbp), %eax    # EAX = r   (o valor de retorno é sempre colocado em EAX)
	popq	%rbp              # restaura o ponteiro anterior da base
	ret                       # retorna para a chamadora
	.size	somador, .-somador
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$2, a(%rip)
	movl	$3, b(%rip)
	movl	b(%rip), %eax
	leal	2(%rax), %ecx
	movl	a(%rip), %eax
	addl	$1, %eax
	movl	$5, %edx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	somador
	movl	%eax, soma(%rip)
	movl	a(%rip), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	b(%rip), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	soma(%rip), %eax
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	popq	%rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406"
	.section	.note.GNU-stack,"",@progbits
