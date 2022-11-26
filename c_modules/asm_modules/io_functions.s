	.file	"io_functions.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%lf"
	.text
	.globl	readDouble
	.type	readDouble, @function
readDouble:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	mov	QWORD PTR -16[rbp], rsi
	cmp	QWORD PTR -8[rbp], 0
	jne	.L2
	mov	eax, 1
	jmp	.L3
.L2:
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, 0
.L3:
	leave
	ret
	.size	readDouble, .-readDouble
	.section	.rodata
.LC1:
	.string	"%lf\n"
	.text
	.globl	printDouble
	.type	printDouble, @function
printDouble:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	movsd	QWORD PTR -16[rbp], xmm0
	cmp	QWORD PTR -8[rbp], 0
	jne	.L5
	mov	eax, 1
	jmp	.L6
.L5:
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	eax, 0
.L6:
	leave
	ret
	.size	printDouble, .-printDouble
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
