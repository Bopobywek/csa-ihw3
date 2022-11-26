	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	calculate
	.type	calculate, @function
calculate:
.LFB50:
	.cfi_startproc
	endbr64
	movsd	xmm6, QWORD PTR EPS[rip]
	movapd	xmm5, xmm6
	xorpd	xmm5, XMMWORD PTR .LC1[rip]
	movapd	xmm1, xmm0
	mov	edx, 2
	pxor	xmm3, xmm3
	jmp	.L2
.L3:
	addsd	xmm3, xmm1
	mulsd	xmm1, xmm0
	lea	rax, -1[rdx]
	pxor	xmm2, xmm2
	cvtsi2sd	xmm2, rax
	pxor	xmm4, xmm4
	cvtsi2sd	xmm4, rdx
	divsd	xmm2, xmm4
	mulsd	xmm1, xmm2
	add	rdx, 1
.L2:
	comisd	xmm5, xmm1
	ja	.L3
	comisd	xmm1, xmm6
	ja	.L3
	xorpd	xmm3, XMMWORD PTR .LC1[rip]
	movapd	xmm0, xmm3
	ret
	.cfi_endproc
.LFE50:
	.size	calculate, .-calculate
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%lf"
	.text
	.globl	readDouble
	.type	readDouble, @function
readDouble:
.LFB51:
	.cfi_startproc
	endbr64
	mov	eax, 1
	test	rdi, rdi
	je	.L8
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	mov	rdx, rsi
	lea	rsi, .LC2[rip]
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
.L8:
	ret
	.cfi_endproc
.LFE51:
	.size	readDouble, .-readDouble
	.section	.rodata.str1.1
.LC3:
	.string	"%lf\n"
	.text
	.globl	printDouble
	.type	printDouble, @function
printDouble:
.LFB52:
	.cfi_startproc
	endbr64
	mov	eax, 1
	test	rdi, rdi
	je	.L15
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	lea	rdx, .LC3[rip]
	mov	esi, 1
	call	__fprintf_chk@PLT
	mov	eax, 0
	add	rsp, 8
	.cfi_def_cfa_offset 8
	ret
.L15:
	ret
	.cfi_endproc
.LFE52:
	.size	printDouble, .-printDouble
	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
.LFB53:
	.cfi_startproc
	endbr64
	movsd	xmm1, QWORD PTR .LC4[rip]
	comisd	xmm1, xmm0
	jb	.L23
	comisd	xmm0, QWORD PTR .LC5[rip]
	setnb	al
	movzx	eax, al
	ret
.L23:
	mov	eax, 0
	ret
	.cfi_endproc
.LFE53:
	.size	validateNumber, .-validateNumber
	.globl	max
	.type	max, @function
max:
.LFB54:
	.cfi_startproc
	endbr64
	cmp	edi, esi
	mov	eax, esi
	cmovge	eax, edi
	ret
	.cfi_endproc
.LFE54:
	.size	max, .-max
	.globl	min
	.type	min, @function
min:
.LFB55:
	.cfi_startproc
	endbr64
	minsd	xmm1, xmm0
	movapd	xmm0, xmm1
	ret
	.cfi_endproc
.LFE55:
	.size	min, .-min
	.globl	getRandomDouble
	.type	getRandomDouble, @function
getRandomDouble:
.LFB56:
	.cfi_startproc
	endbr64
	sub	rsp, 8
	.cfi_def_cfa_offset 16
	call	rand@PLT
	test	eax, eax
	mov	edx, 1
	cmovle	eax, edx
	sub	eax, 1
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	divsd	xmm0, QWORD PTR .LC6[rip]
	addsd	xmm0, xmm0
	subsd	xmm0, QWORD PTR .LC7[rip]
	comisd	xmm0, QWORD PTR .LC4[rip]
	ja	.L34
.L29:
	add	rsp, 8
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L34:
	.cfi_restore_state
	movsd	xmm0, QWORD PTR .LC4[rip]
	jmp	.L29
	.cfi_endproc
.LFE56:
	.size	getRandomDouble, .-getRandomDouble
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB57:
	.cfi_startproc
	endbr64
	mov	r10, rdx
	imul	r9, rdi, 1000
	movabs	r8, 4835703278458516699
	mov	rax, rsi
	imul	r8
	sar	rdx, 18
	sar	rsi, 63
	sub	rdx, rsi
	lea	rdi, [r9+rdx]
	imul	r10, r10, 1000
	mov	rax, rcx
	imul	r8
	sar	rdx, 18
	sar	rcx, 63
	sub	rdx, rcx
	add	r10, rdx
	mov	rax, rdi
	sub	rax, r10
	ret
	.cfi_endproc
.LFE57:
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB58:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	sub	rsp, 64
	.cfi_def_cfa_offset 112
	movsd	QWORD PTR 8[rsp], xmm0
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 56[rsp], rax
	xor	eax, eax
	test	rdi, rdi
	jle	.L40
	mov	r12, rdi
	mov	r13, rsi
	mov	ebx, 0
	mov	ebp, 0
	lea	r14, 16[rsp]
.L38:
	mov	rsi, r14
	mov	edi, 1
	call	clock_gettime@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	call	calculate
	movsd	QWORD PTR 0[r13], xmm0
	lea	rsi, 32[rsp]
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR 16[rsp]
	mov	rcx, QWORD PTR 24[rsp]
	mov	rdi, QWORD PTR 32[rsp]
	mov	rsi, QWORD PTR 40[rsp]
	call	getTimeDiff
	add	rbp, rax
	add	rbx, 1
	cmp	r12, rbx
	jne	.L38
.L36:
	mov	rax, QWORD PTR 56[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L43
	mov	rax, rbp
	add	rsp, 64
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	pop	rbx
	.cfi_def_cfa_offset 40
	pop	rbp
	.cfi_def_cfa_offset 32
	pop	r12
	.cfi_def_cfa_offset 24
	pop	r13
	.cfi_def_cfa_offset 16
	pop	r14
	.cfi_def_cfa_offset 8
	ret
.L40:
	.cfi_restore_state
	mov	ebp, 0
	jmp	.L36
.L43:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE58:
	.size	measureTime, .-measureTime
	.section	.rodata.str1.1
.LC8:
	.string	"r"
.LC9:
	.string	"w"
.LC10:
	.string	"rt:s:i:o:"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC11:
	.string	"Enter a real number in range [-1; 1):"
	.align 8
.LC12:
	.string	"Error! The input file could not be read."
	.align 8
.LC13:
	.string	"Error! The input number is not in the specified range."
	.align 8
.LC14:
	.string	"Running current test case %ld times...\n"
	.section	.rodata.str1.1
.LC15:
	.string	"Elapsed time: %ld ms\n"
	.section	.rodata.str1.8
	.align 8
.LC16:
	.string	"\nError! Output data cannot be written."
	.text
	.globl	main
	.type	main, @function
main:
.LFB59:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	r12d, edi
	mov	rbp, rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
	mov	r14, QWORD PTR stdin[rip]
	mov	r15, QWORD PTR stdout[rip]
	mov	QWORD PTR 8[rsp], 0
	mov	DWORD PTR [rsp], 42
	mov	DWORD PTR 4[rsp], 0
	mov	r13d, 0
	lea	rbx, .L49[rip]
.L45:
	lea	rdx, .LC10[rip]
	mov	rsi, rbp
	mov	edi, r12d
	call	getopt@PLT
	cmp	eax, -1
	je	.L63
	cmp	eax, 63
	je	.L46
	lea	edx, -105[rax]
	cmp	edx, 11
	ja	.L45
	ja	.L45
	mov	eax, edx
	movsx	rax, DWORD PTR [rbx+rax*4]
	add	rax, rbx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L49:
	.long	.L53-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L52-.L49
	.long	.L45-.L49
	.long	.L45-.L49
	.long	.L51-.L49
	.long	.L50-.L49
	.long	.L48-.L49
	.text
.L51:
	mov	r13d, 1
	jmp	.L45
.L53:
	lea	rsi, .LC8[rip]
	mov	rdi, QWORD PTR optarg[rip]
	call	fopen@PLT
	mov	r14, rax
	jmp	.L45
.L52:
	lea	rsi, .LC9[rip]
	mov	rdi, QWORD PTR optarg[rip]
	call	fopen@PLT
	mov	r15, rax
	jmp	.L45
.L50:
	mov	edx, 10
	mov	esi, 0
	mov	rdi, QWORD PTR optarg[rip]
	call	strtol@PLT
	mov	DWORD PTR [rsp], eax
	jmp	.L45
.L48:
	mov	edx, 10
	mov	esi, 0
	mov	rdi, QWORD PTR optarg[rip]
	call	strtoll@PLT
	mov	QWORD PTR 8[rsp], rax
	mov	DWORD PTR 4[rsp], 1
	jmp	.L45
.L63:
	mov	edi, DWORD PTR [rsp]
	call	srand@PLT
	test	r13d, r13d
	jne	.L64
	cmp	QWORD PTR stdin[rip], r14
	je	.L65
	lea	rsi, 24[rsp]
	mov	rdi, r14
	call	readDouble
.L58:
	cmp	eax, 1
	je	.L66
.L56:
	mov	rbx, QWORD PTR 24[rsp]
	movq	xmm0, rbx
	call	validateNumber
	test	eax, eax
	je	.L67
	movq	xmm0, rbx
	call	calculate
	movsd	QWORD PTR 32[rsp], xmm0
	cmp	DWORD PTR 4[rsp], 0
	jne	.L68
.L60:
	movsd	xmm0, QWORD PTR 32[rsp]
	mov	rdi, r15
	call	printDouble
	test	eax, eax
	jne	.L69
.L46:
	mov	rax, QWORD PTR 40[rsp]
	xor	rax, QWORD PTR fs:40
	jne	.L70
	mov	eax, 0
	add	rsp, 56
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	pop	rbx
	.cfi_def_cfa_offset 48
	pop	rbp
	.cfi_def_cfa_offset 40
	pop	r12
	.cfi_def_cfa_offset 32
	pop	r13
	.cfi_def_cfa_offset 24
	pop	r14
	.cfi_def_cfa_offset 16
	pop	r15
	.cfi_def_cfa_offset 8
	ret
.L64:
	.cfi_restore_state
	mov	eax, 0
	call	getRandomDouble
	movsd	QWORD PTR 24[rsp], xmm0
	lea	rsi, .LC3[rip]
	mov	edi, 1
	mov	eax, 1
	call	__printf_chk@PLT
	jmp	.L56
.L65:
	lea	rdi, .LC11[rip]
	call	puts@PLT
	lea	rsi, 24[rsp]
	mov	rdi, r14
	call	readDouble
	jmp	.L58
.L66:
	lea	rdi, .LC12[rip]
	call	puts@PLT
	jmp	.L46
.L67:
	lea	rdi, .LC13[rip]
	call	puts@PLT
	jmp	.L46
.L68:
	mov	rbx, QWORD PTR 8[rsp]
	mov	rdx, rbx
	lea	rsi, .LC14[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	lea	rsi, 32[rsp]
	movsd	xmm0, QWORD PTR 24[rsp]
	mov	rdi, rbx
	call	measureTime
	mov	rdx, rax
	lea	rsi, .LC15[rip]
	mov	edi, 1
	mov	eax, 0
	call	__printf_chk@PLT
	jmp	.L60
.L69:
	lea	rdi, .LC16[rip]
	call	puts@PLT
	jmp	.L46
.L70:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE59:
	.size	main, .-main
	.globl	EPS
	.data
	.align 8
	.type	EPS, @object
	.size	EPS, 8
EPS:
	.long	2596056904
	.long	1048238066
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC4:
	.long	3642132267
	.long	1072691150
	.align 8
.LC5:
	.long	0
	.long	-1074790400
	.align 8
.LC6:
	.long	4290772992
	.long	1105199103
	.align 8
.LC7:
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
