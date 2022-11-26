	.file	"solution.c"
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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	movsd	QWORD PTR -40[rbp], xmm0
	pxor	xmm0, xmm0
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	QWORD PTR -8[rbp], 2
	jmp	.L2
.L3:
	movsd	xmm0, QWORD PTR -24[rbp]
	addsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	sub	rax, 1
	cvtsi2sd	xmm0, rax
	cvtsi2sd	xmm1, QWORD PTR -8[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	QWORD PTR -8[rbp], 1
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
	movsd	xmm0, QWORD PTR -24[rbp]
	movq	xmm1, QWORD PTR .LC1[rip]
	xorpd	xmm0, xmm1
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	calculate, .-calculate
	.section	.rodata
.LC2:
	.string	"%lf"
	.text
	.globl	readDouble
	.type	readDouble, @function
readDouble:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	mov	QWORD PTR -16[rbp], rsi
	cmp	QWORD PTR -8[rbp], 0
	jne	.L6
	mov	eax, 1
	jmp	.L7
.L6:
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	eax, 0
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	readDouble, .-readDouble
	.section	.rodata
.LC3:
	.string	"%lf\n"
	.text
	.globl	printDouble
	.type	printDouble, @function
printDouble:
.LFB8:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	QWORD PTR -8[rbp], rdi
	movsd	QWORD PTR -16[rbp], xmm0
	cmp	QWORD PTR -8[rbp], 0
	jne	.L9
	mov	eax, 1
	jmp	.L10
.L9:
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	eax, 0
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	printDouble, .-printDouble
	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
.LFB9:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	comisd	xmm0, QWORD PTR -8[rbp]
	jb	.L12
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC5[rip]
	comisd	xmm0, xmm1
	jb	.L12
	mov	eax, 1
	jmp	.L16
.L12:
	mov	eax, 0
.L16:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	validateNumber, .-validateNumber
	.globl	max
	.type	max, @function
max:
.LFB10:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -4[rbp], edi
	mov	DWORD PTR -8[rbp], esi
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -8[rbp]
	jle	.L20
	mov	eax, DWORD PTR -4[rbp]
	jmp	.L21
.L20:
	mov	eax, DWORD PTR -8[rbp]
.L21:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	max, .-max
	.globl	min
	.type	min, @function
min:
.LFB11:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	QWORD PTR -16[rbp], xmm1
	movsd	xmm0, QWORD PTR -8[rbp]
	comisd	xmm0, QWORD PTR -16[rbp]
	jbe	.L27
	movsd	xmm0, QWORD PTR -16[rbp]
	jmp	.L25
.L27:
	movsd	xmm0, QWORD PTR -8[rbp]
.L25:
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	min, .-min
	.globl	getRandomDouble
	.type	getRandomDouble, @function
getRandomDouble:
.LFB12:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	call	rand@PLT
	mov	esi, 1
	mov	edi, eax
	call	max
	sub	eax, 1
	mov	DWORD PTR -4[rbp], eax
	cvtsi2sd	xmm0, DWORD PTR -4[rbp]
	movsd	xmm1, QWORD PTR .LC6[rip]
	divsd	xmm0, xmm1
	addsd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC7[rip]
	subsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC4[rip]
	call	min
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	getRandomDouble, .-getRandomDouble
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB13:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
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
	mov	QWORD PTR -16[rbp], rax
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
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, QWORD PTR -8[rbp]
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB14:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 96
	mov	QWORD PTR -72[rbp], rdi
	movsd	QWORD PTR -80[rbp], xmm0
	mov	QWORD PTR -88[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	QWORD PTR -64[rbp], 0
	mov	QWORD PTR -56[rbp], 0
	jmp	.L33
.L34:
	lea	rax, -48[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -80[rbp]
	movq	xmm0, rax
	call	calculate
	movq	rax, xmm0
	mov	rdx, QWORD PTR -88[rbp]
	mov	QWORD PTR [rdx], rax
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -48[rbp]
	mov	rdx, QWORD PTR -40[rbp]
	mov	rdi, QWORD PTR -32[rbp]
	mov	rsi, QWORD PTR -24[rbp]
	mov	rcx, rdx
	mov	rdx, rax
	call	getTimeDiff
	add	QWORD PTR -64[rbp], rax
	add	QWORD PTR -56[rbp], 1
.L33:
	mov	rax, QWORD PTR -56[rbp]
	cmp	rax, QWORD PTR -72[rbp]
	jl	.L34
	mov	rax, QWORD PTR -64[rbp]
	mov	rcx, QWORD PTR -8[rbp]
	xor	rcx, QWORD PTR fs:40
	je	.L36
	call	__stack_chk_fail@PLT
.L36:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	measureTime, .-measureTime
	.section	.rodata
.LC8:
	.string	"r"
.LC9:
	.string	"w"
.LC10:
	.string	"rt:s:i:o:"
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
.LC15:
	.string	"Elapsed time: %ld ms\n"
	.align 8
.LC16:
	.string	"\nError! Output data cannot be written."
	.text
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -40[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -32[rbp], rax
	mov	DWORD PTR -76[rbp], 0
	mov	DWORD PTR -72[rbp], 0
	mov	DWORD PTR -68[rbp], 42
	mov	QWORD PTR -24[rbp], 0
	jmp	.L38
.L47:
	cmp	DWORD PTR -60[rbp], 63
	je	.L39
	cmp	DWORD PTR -60[rbp], 63
	jl	.L38
	cmp	DWORD PTR -60[rbp], 116
	jg	.L38
	cmp	DWORD PTR -60[rbp], 105
	jl	.L38
	mov	eax, DWORD PTR -60[rbp]
	sub	eax, 105
	cmp	eax, 11
	ja	.L38
	mov	eax, eax
	lea	rdx, 0[0+rax*4]
	lea	rax, .L41[rip]
	mov	eax, DWORD PTR [rdx+rax]
	cdqe
	lea	rdx, .L41[rip]
	add	rax, rdx
	notrack jmp	rax
	.section	.rodata
	.align 4
	.align 4
.L41:
	.long	.L45-.L41
	.long	.L38-.L41
	.long	.L38-.L41
	.long	.L38-.L41
	.long	.L38-.L41
	.long	.L38-.L41
	.long	.L44-.L41
	.long	.L38-.L41
	.long	.L38-.L41
	.long	.L43-.L41
	.long	.L42-.L41
	.long	.L40-.L41
	.text
.L43:
	mov	DWORD PTR -76[rbp], 1
	jmp	.L38
.L45:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	jmp	.L38
.L44:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	jmp	.L38
.L42:
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -68[rbp], eax
	jmp	.L38
.L40:
	mov	DWORD PTR -72[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -24[rbp], rax
	jmp	.L38
.L39:
	mov	eax, 0
	jmp	.L55
.L38:
	mov	rcx, QWORD PTR -96[rbp]
	mov	eax, DWORD PTR -84[rbp]
	lea	rdx, .LC10[rip]
	mov	rsi, rcx
	mov	edi, eax
	call	getopt@PLT
	mov	DWORD PTR -60[rbp], eax
	cmp	DWORD PTR -60[rbp], -1
	jne	.L47
	mov	eax, DWORD PTR -68[rbp]
	mov	edi, eax
	call	srand@PLT
	mov	DWORD PTR -64[rbp], 0
	cmp	DWORD PTR -76[rbp], 0
	je	.L48
	mov	eax, 0
	call	getRandomDouble
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	movq	xmm0, rax
	lea	rdi, .LC3[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L49
.L48:
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -40[rbp], rax
	jne	.L50
	lea	rdi, .LC11[rip]
	call	puts@PLT
	lea	rdx, -56[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	readDouble
	mov	DWORD PTR -64[rbp], eax
	jmp	.L49
.L50:
	lea	rdx, -56[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	readDouble
	mov	DWORD PTR -64[rbp], eax
.L49:
	cmp	DWORD PTR -64[rbp], 1
	jne	.L51
	lea	rdi, .LC12[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L55
.L51:
	mov	rax, QWORD PTR -56[rbp]
	movq	xmm0, rax
	call	validateNumber
	mov	DWORD PTR -64[rbp], eax
	cmp	DWORD PTR -64[rbp], 0
	jne	.L52
	lea	rdi, .LC13[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L55
.L52:
	mov	rax, QWORD PTR -56[rbp]
	movq	xmm0, rax
	call	calculate
	movq	rax, xmm0
	mov	QWORD PTR -48[rbp], rax
	cmp	DWORD PTR -72[rbp], 0
	je	.L53
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rax
	lea	rdi, .LC14[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rdx, QWORD PTR -56[rbp]
	lea	rcx, -48[rbp]
	mov	rax, QWORD PTR -24[rbp]
	mov	rsi, rcx
	movq	xmm0, rdx
	mov	rdi, rax
	call	measureTime
	mov	QWORD PTR -16[rbp], rax
	mov	rax, QWORD PTR -16[rbp]
	mov	rsi, rax
	lea	rdi, .LC15[rip]
	mov	eax, 0
	call	printf@PLT
.L53:
	mov	rdx, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	call	printDouble
	mov	DWORD PTR -64[rbp], eax
	cmp	DWORD PTR -64[rbp], 0
	je	.L54
	lea	rdi, .LC16[rip]
	call	puts@PLT
.L54:
	mov	eax, 0
.L55:
	mov	rcx, QWORD PTR -8[rbp]
	xor	rcx, QWORD PTR fs:40
	je	.L56
	call	__stack_chk_fail@PLT
.L56:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.section	.rodata
	.align 16
.LC1:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
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
