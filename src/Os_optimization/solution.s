	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	calculate
	.type	calculate, @function
calculate:
.LFB35:
	.cfi_startproc
	endbr64
	movsd	xmm5, QWORD PTR EPS[rip]
	movq	xmm4, QWORD PTR .LC1[rip]
	movapd	xmm1, xmm0
	xorps	xmm2, xmm2
	mov	edx, 2
	movapd	xmm6, xmm5
	xorps	xmm6, xmm4
.L2:
	comisd	xmm6, xmm1
	jbe	.L5
.L3:
	lea	rax, -1[rdx]
	addsd	xmm2, xmm1
	mulsd	xmm1, xmm0
	cvtsi2sd	xmm7, rdx
	inc	rdx
	cvtsi2sd	xmm3, rax
	divsd	xmm3, xmm7
	mulsd	xmm1, xmm3
	jmp	.L2
.L5:
	comisd	xmm1, xmm5
	ja	.L3
	xorps	xmm2, xmm4
	movapd	xmm0, xmm2
	ret
	.cfi_endproc
.LFE35:
	.size	calculate, .-calculate
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%lf"
	.text
	.globl	readDouble
	.type	readDouble, @function
readDouble:
.LFB36:
	.cfi_startproc
	endbr64
	test	rdi, rdi
	je	.L9
	push	rax
	.cfi_def_cfa_offset 16
	mov	rdx, rsi
	xor	eax, eax
	lea	rsi, .LC2[rip]
	call	__isoc99_fscanf@PLT
	xor	eax, eax
	pop	rdx
	.cfi_def_cfa_offset 8
	ret
.L9:
	mov	eax, 1
	ret
	.cfi_endproc
.LFE36:
	.size	readDouble, .-readDouble
	.section	.rodata.str1.1
.LC3:
	.string	"%lf\n"
	.text
	.globl	printDouble
	.type	printDouble, @function
printDouble:
.LFB37:
	.cfi_startproc
	endbr64
	mov	eax, 1
	test	rdi, rdi
	je	.L18
	push	rdx
	.cfi_def_cfa_offset 16
	mov	esi, 1
	lea	rdx, .LC3[rip]
	call	__fprintf_chk@PLT
	xor	eax, eax
	pop	rcx
	.cfi_def_cfa_offset 8
	ret
.L18:
	ret
	.cfi_endproc
.LFE37:
	.size	printDouble, .-printDouble
	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
.LFB38:
	.cfi_startproc
	endbr64
	movsd	xmm1, QWORD PTR .LC4[rip]
	comisd	xmm1, xmm0
	jb	.L26
	xor	eax, eax
	comisd	xmm0, QWORD PTR .LC5[rip]
	setnb	al
	ret
.L26:
	xor	eax, eax
	ret
	.cfi_endproc
.LFE38:
	.size	validateNumber, .-validateNumber
	.globl	max
	.type	max, @function
max:
.LFB39:
	.cfi_startproc
	endbr64
	cmp	edi, esi
	mov	eax, esi
	cmovge	eax, edi
	ret
	.cfi_endproc
.LFE39:
	.size	max, .-max
	.globl	min
	.type	min, @function
min:
.LFB40:
	.cfi_startproc
	endbr64
	minsd	xmm1, xmm0
	movapd	xmm0, xmm1
	ret
	.cfi_endproc
.LFE40:
	.size	min, .-min
	.globl	getRandomDouble
	.type	getRandomDouble, @function
getRandomDouble:
.LFB41:
	.cfi_startproc
	endbr64
	push	rax
	.cfi_def_cfa_offset 16
	call	rand@PLT
	mov	edx, 1
	movsd	xmm1, QWORD PTR .LC4[rip]
	test	eax, eax
	cmovle	eax, edx
	dec	eax
	cvtsi2sd	xmm0, eax
	divsd	xmm0, QWORD PTR .LC6[rip]
	addsd	xmm0, xmm0
	subsd	xmm0, QWORD PTR .LC7[rip]
	pop	rdx
	.cfi_def_cfa_offset 8
	minsd	xmm1, xmm0
	movapd	xmm0, xmm1
	ret
	.cfi_endproc
.LFE41:
	.size	getRandomDouble, .-getRandomDouble
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB42:
	.cfi_startproc
	endbr64
	mov	rax, rsi
	mov	r9d, 1000000
	mov	r8, rdx
	cqo
	imul	rdi, rdi, 1000
	idiv	r9
	imul	r8, r8, 1000
	add	rdi, rax
	mov	rax, rcx
	cqo
	idiv	r9
	add	r8, rax
	mov	rax, rdi
	sub	rax, r8
	ret
	.cfi_endproc
.LFE42:
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB43:
	.cfi_startproc
	endbr64
	push	r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	push	r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	mov	r13, rsi
	push	r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	xor	r12d, r12d
	push	rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	xor	ebp, ebp
	push	rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	mov	rbx, rdi
	sub	rsp, 64
	.cfi_def_cfa_offset 112
	movsd	QWORD PTR 8[rsp], xmm0
	lea	r14, 24[rsp]
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 56[rsp], rax
	xor	eax, eax
.L39:
	cmp	rbp, rbx
	jge	.L43
	mov	rsi, r14
	mov	edi, 1
	inc	rbp
	call	clock_gettime@PLT
	movsd	xmm0, QWORD PTR 8[rsp]
	call	calculate
	lea	rsi, 40[rsp]
	mov	edi, 1
	movsd	QWORD PTR 0[r13], xmm0
	call	clock_gettime@PLT
	mov	rdx, QWORD PTR 24[rsp]
	mov	rcx, QWORD PTR 32[rsp]
	mov	rdi, QWORD PTR 40[rsp]
	mov	rsi, QWORD PTR 48[rsp]
	call	getTimeDiff
	add	r12, rax
	jmp	.L39
.L43:
	mov	rax, QWORD PTR 56[rsp]
	xor	rax, QWORD PTR fs:40
	je	.L41
	call	__stack_chk_fail@PLT
.L41:
	add	rsp, 64
	.cfi_def_cfa_offset 48
	mov	rax, r12
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
	.cfi_endproc
.LFE43:
	.size	measureTime, .-measureTime
	.section	.rodata.str1.1
.LC8:
	.string	"r"
.LC9:
	.string	"w"
.LC10:
	.string	"rt:s:i:o:"
.LC11:
	.string	"Enter a real number in range [-1; 1):"
.LC12:
	.string	"Error! The input file could not be read."
.LC13:
	.string	"Error! The input number is not in the specified range."
.LC14:
	.string	"Running current test case %ld times...\n"
.LC15:
	.string	"Elapsed time: %ld ms\n"
.LC16:
	.string	"\nError! Output data cannot be written."
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB44:
	.cfi_startproc
	endbr64
	push	r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	xor	r15d, r15d
	push	r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	mov	r14d, 42
	push	r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	push	r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	xor	r12d, r12d
	push	rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	push	rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	xor	ebx, ebx
	sub	rsp, 56
	.cfi_def_cfa_offset 112
	mov	rbp, QWORD PTR stdin[rip]
	mov	r13, QWORD PTR stdout[rip]
	mov	DWORD PTR [rsp], edi
	mov	QWORD PTR 8[rsp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR 40[rsp], rax
	xor	eax, eax
.L45:
	mov	rsi, QWORD PTR 8[rsp]
	mov	edi, DWORD PTR [rsp]
	lea	rdx, .LC10[rip]
	call	getopt@PLT
	cmp	eax, -1
	je	.L73
	cmp	eax, 63
	je	.L46
	sub	eax, 105
	cmp	eax, 11
	ja	.L45
	lea	rcx, .L49[rip]
	movsx	rax, DWORD PTR [rcx+rax*4]
	add	rax, rcx
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
	.section	.text.startup
.L51:
	mov	r15d, 1
	jmp	.L45
.L53:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC8[rip]
	call	fopen@PLT
	mov	rbp, rax
	jmp	.L45
.L52:
	mov	rdi, QWORD PTR optarg[rip]
	lea	rsi, .LC9[rip]
	call	fopen@PLT
	mov	r13, rax
	jmp	.L45
.L50:
	mov	rdi, QWORD PTR optarg[rip]
	call	atoi@PLT
	mov	r14d, eax
	jmp	.L45
.L48:
	mov	rdi, QWORD PTR optarg[rip]
	mov	ebx, 1
	call	atoll@PLT
	mov	r12, rax
	jmp	.L45
.L73:
	mov	edi, r14d
	call	srand@PLT
	test	r15d, r15d
	je	.L55
	xor	eax, eax
	call	getRandomDouble
	lea	rsi, .LC3[rip]
	mov	edi, 1
	mov	al, 1
	movsd	QWORD PTR 24[rsp], xmm0
	call	__printf_chk@PLT
	jmp	.L56
.L55:
	cmp	QWORD PTR stdin[rip], rbp
	lea	rsi, 24[rsp]
	jne	.L57
	lea	rdi, .LC11[rip]
	mov	QWORD PTR [rsp], rsi
	call	puts@PLT
	mov	rsi, QWORD PTR [rsp]
.L57:
	mov	rdi, rbp
	call	readDouble
	lea	rdi, .LC12[rip]
	dec	eax
	je	.L72
.L56:
	movsd	xmm0, QWORD PTR 24[rsp]
	call	validateNumber
	lea	rdi, .LC13[rip]
	test	eax, eax
	je	.L72
	call	calculate
	movsd	QWORD PTR 32[rsp], xmm0
	test	ebx, ebx
	je	.L60
	mov	rdx, r12
	lea	rsi, .LC14[rip]
	mov	edi, 1
	xor	eax, eax
	call	__printf_chk@PLT
	movsd	xmm0, QWORD PTR 24[rsp]
	lea	rsi, 32[rsp]
	mov	rdi, r12
	call	measureTime
	lea	rsi, .LC15[rip]
	mov	edi, 1
	mov	rdx, rax
	xor	eax, eax
	call	__printf_chk@PLT
.L60:
	movsd	xmm0, QWORD PTR 32[rsp]
	mov	rdi, r13
	call	printDouble
	test	eax, eax
	je	.L46
	lea	rdi, .LC16[rip]
.L72:
	call	puts@PLT
.L46:
	mov	rax, QWORD PTR 40[rsp]
	xor	rax, QWORD PTR fs:40
	je	.L61
	call	__stack_chk_fail@PLT
.L61:
	add	rsp, 56
	.cfi_def_cfa_offset 56
	xor	eax, eax
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
	.cfi_endproc
.LFE44:
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
