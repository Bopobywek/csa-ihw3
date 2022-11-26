	.file	"time_functions.c"
	.intel_syntax noprefix
	.text
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
	endbr64
	push	rbp
	mov	rbp, rsp
	mov	rax, rsi
	mov	r8, rdi
	mov	rsi, r8
	mov	rdi, r9
	mov	rdi, rax
	mov	QWORD PTR -32[rbp], rsi
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -48[rbp], rdx
	mov	QWORD PTR -40[rbp], rcx
	mov	rax, QWORD PTR -32[rbp]
	imul	rsi, rax, 1000
	mov	rcx, QWORD PTR -24[rbp]
	movabs	rdx, 4835703278458516699
	mov	rax, rcx
	imul	rdx
	sar	rdx, 18
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	add	rax, rsi
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -48[rbp]
	imul	rsi, rax, 1000
	mov	rcx, QWORD PTR -40[rbp]
	movabs	rdx, 4835703278458516699
	mov	rax, rcx
	imul	rdx
	sar	rdx, 18
	mov	rax, rcx
	sar	rax, 63
	sub	rdx, rax
	mov	rax, rdx
	add	rax, rsi
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, QWORD PTR -16[rbp]
	pop	rbp
	ret
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	QWORD PTR -56[rbp], rdi
	movsd	QWORD PTR -64[rbp], xmm0
	mov	QWORD PTR -72[rbp], rsi
	mov	QWORD PTR -8[rbp], 0
	mov	QWORD PTR -16[rbp], 0
	jmp	.L4
.L5:
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	call	calculate@PLT
	movq	rax, xmm0
	mov	rdx, QWORD PTR -72[rbp]
	mov	QWORD PTR [rdx], rax
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	mov	rdi, QWORD PTR -48[rbp]
	mov	rsi, QWORD PTR -40[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	getTimeDiff
	add	QWORD PTR -8[rbp], rax
	add	QWORD PTR -16[rbp], 1
.L4:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -56[rbp]
	jl	.L5
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
	.size	measureTime, .-measureTime
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
