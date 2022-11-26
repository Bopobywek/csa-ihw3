	.file	"calculations.c"
	.intel_syntax noprefix
	.text
	.globl	EPS
	.data
	.align 8
	.type	EPS, @object
	.size	EPS, 8
EPS:
	.long	2596056904
	.long	1048238066
	.text
	.globl	calculate
	.type	calculate, @function
calculate:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -40[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	QWORD PTR -24[rbp], 2
	jmp	.L2
.L3:
	movsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	rax, QWORD PTR -24[rbp]
	sub	rax, 1
	cvtsi2sd	xmm0, rax
	cvtsi2sd	xmm1, QWORD PTR -24[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	QWORD PTR -24[rbp], 1
.L2:
	movsd	xmm0, QWORD PTR EPS[rip]
	movq	xmm1, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR -16[rbp]
	ja	.L3
	movsd	xmm1, QWORD PTR EPS[rip]
	movsd	xmm0, QWORD PTR -16[rbp]
	comisd	xmm0, xmm1
	ja	.L3
	movsd	xmm0, QWORD PTR -8[rbp]
	movq	xmm1, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	pop	rbp
	ret
	.size	calculate, .-calculate
	.section	.rodata
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
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
