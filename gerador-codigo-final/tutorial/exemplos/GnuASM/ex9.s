	.file	"ex9.c"
	.comm	a,4,4
	.comm	b,4,4
	.comm	soma,4,4
	.text
	.globl	gteste
	.type	gteste, @function
gteste:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	addl	$1, %eax
	popq	%rbp
	ret
	.size	gteste, .-gteste
	.globl	fteste
	.type	fteste, @function
fteste:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$56, %rsp

	movl	%edi, -36(%rbp)      # a
	movl	%esi, -40(%rbp)      # b
	movl	%edx, -44(%rbp)      # c
	movl	%ecx, -48(%rbp)      # d
	movl	%r8d, -52(%rbp)      # e
	movl	%r9d, -56(%rbp)      # f
	movl	$1, -36(%rbp)        # a = 1
	movl	$2, -40(%rbp)        # b = 2
	movl	$3, -44(%rbp)        # c = 3
	movl	$4, -48(%rbp)        # d = 4
	movl	$5, -52(%rbp)        # e = 5
	movl	$6, -56(%rbp)        # f = 6
	movl	$11, -28(%rbp)       # g = 11
	movl	$12, -24(%rbp)       # h = 12
	movl	$13, -20(%rbp)       # i = 13
	movl	$14, -16(%rbp)       # j = 14
	movl	$15, -12(%rbp)       # k = 15
	movl	$16, -8(%rbp)        # l = 16
	movl	$17, -4(%rbp)        # m = 17

	movl	-36(%rbp), %edx
	movl	-40(%rbp), %eax
	addl	%eax, %edx
	movl	-44(%rbp), %eax
	addl	%eax, %edx
	movl	-48(%rbp), %eax
	addl	%eax, %edx
	movl	-52(%rbp), %eax
	addl	%eax, %edx
	movl	-56(%rbp), %eax
	addl	%eax, %edx
	movl	-28(%rbp), %eax
	addl	%eax, %edx
	movl	-24(%rbp), %eax
	addl	%eax, %edx
	movl	-20(%rbp), %eax
	addl	%eax, %edx
	movl	-16(%rbp), %eax
	addl	%eax, %edx
	movl	-12(%rbp), %eax
	addl	%eax, %edx
	movl	-8(%rbp), %eax
	addl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movl	%eax, %edi
	call	gteste
	leave
	ret
	.size	fteste, .-fteste
	.globl	multiplicador
	.type	multiplicador, @function
multiplicador:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	$5, -4(%rbp)
	movl	-4(%rbp), %eax
	imull	-20(%rbp), %eax
	imull	-24(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	popq	%rbp
	ret
	.size	multiplicador, .-multiplicador
	.globl	somador
	.type	somador, @function
somador:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -28(%rbp)
	movl	$1, -8(%rbp)
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %eax
	addl	%eax, %edx
	movl	-28(%rbp), %eax
	addl	%eax, %edx
	movl	-8(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	multiplicador
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	leave
	ret
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
