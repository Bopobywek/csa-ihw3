	.file	"helpers.c"
	.intel_syntax noprefix
	.text
	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	comisd	xmm0, QWORD PTR -8[rbp]
	jb	.L2
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC1[rip]
	comisd	xmm0, xmm1
	jb	.L2
	mov	eax, 1
	jmp	.L6
.L2:
	mov	eax, 0
.L6:
	pop	rbp
	ret
	.size	validateNumber, .-validateNumber
	.globl	max
	.type	max, @function
max:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -4[rbp], edi
	mov	DWORD PTR -8[rbp], esi
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -8[rbp]
	jle	.L10
	mov	eax, DWORD PTR -4[rbp]
	jmp	.L11
.L10:
	mov	eax, DWORD PTR -8[rbp]
.L11:
	pop	rbp
	ret
	.size	max, .-max
	.globl	min
	.type	min, @function
min:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	QWORD PTR -16[rbp], xmm1
	movsd	xmm0, QWORD PTR -8[rbp]
	comisd	xmm0, QWORD PTR -16[rbp]
	jbe	.L17
	movsd	xmm0, QWORD PTR -16[rbp]
	jmp	.L15
.L17:
	movsd	xmm0, QWORD PTR -8[rbp]
.L15:
	pop	rbp
	ret
	.size	min, .-min
	.globl	getRandomDouble
	.type	getRandomDouble, @function
getRandomDouble:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16
	call	rand@PLT
	mov	esi, 1
	mov	edi, eax
	call	max
	sub	eax, 1
	mov	DWORD PTR -4[rbp], eax
	cvtsi2sd	xmm0, DWORD PTR -4[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	divsd	xmm0, xmm1
	addsd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC3[rip]
	subsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC0[rip]
	call	min
	leave
	ret
	.size	getRandomDouble, .-getRandomDouble
	.section	.rodata
	.align 8
.LC0:
	.long	3642132267
	.long	1072691150
	.align 8
.LC1:
	.long	0
	.long	-1074790400
	.align 8
.LC2:
	.long	4290772992
	.long	1105199103
	.align 8
.LC3:
	.long	0
	.long	1072693248
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
