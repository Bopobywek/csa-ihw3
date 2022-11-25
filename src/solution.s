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
.LC2:
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
	ret
	.size	readDouble, .-readDouble
	.section	.rodata
.LC3:
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
	ret
	.size	printDouble, .-printDouble
	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
	endbr64
	push	rbp
	mov	rbp, rsp
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
	jle	.L20
	mov	eax, DWORD PTR -4[rbp]
	jmp	.L21
.L20:
	mov	eax, DWORD PTR -8[rbp]
.L21:
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
	jbe	.L27
	movsd	xmm0, QWORD PTR -16[rbp]
	jmp	.L25
.L27:
	movsd	xmm0, QWORD PTR -8[rbp]
.L25:
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
	movsd	xmm1, QWORD PTR .LC6[rip]
	divsd	xmm0, xmm1
	addsd	xmm0, xmm0
	movsd	xmm1, QWORD PTR .LC7[rip]
	subsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC4[rip]
	call	min
	leave
	ret
	.size	getRandomDouble, .-getRandomDouble
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
	sub	rsp, 64
	mov	QWORD PTR -56[rbp], rdi
	movsd	QWORD PTR -64[rbp], xmm0
	mov	QWORD PTR -8[rbp], 0
	mov	QWORD PTR -16[rbp], 0
	jmp	.L33
.L34:
	lea	rax, -32[rbp]
	mov	rsi, rax
	mov	edi, 1
	call	clock_gettime@PLT
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	call	calculate
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
.L33:
	mov	rax, QWORD PTR -16[rbp]
	cmp	rax, QWORD PTR -56[rbp]
	jl	.L34
	mov	rax, QWORD PTR -8[rbp]
	leave
	ret
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
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	mov	rax, QWORD PTR stdin[rip]
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR stdout[rip]
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -20[rbp], 0
	mov	DWORD PTR -24[rbp], 0
	mov	DWORD PTR -28[rbp], 42
	mov	QWORD PTR -40[rbp], 0
	jmp	.L37
.L45:
	cmp	DWORD PTR -48[rbp], 116
	je	.L38
	cmp	DWORD PTR -48[rbp], 116
	jg	.L37
	cmp	DWORD PTR -48[rbp], 115
	je	.L39
	cmp	DWORD PTR -48[rbp], 115
	jg	.L37
	cmp	DWORD PTR -48[rbp], 114
	je	.L40
	cmp	DWORD PTR -48[rbp], 114
	jg	.L37
	cmp	DWORD PTR -48[rbp], 111
	je	.L41
	cmp	DWORD PTR -48[rbp], 111
	jg	.L37
	cmp	DWORD PTR -48[rbp], 63
	je	.L42
	cmp	DWORD PTR -48[rbp], 105
	je	.L43
	jmp	.L37
.L40:
	mov	DWORD PTR -20[rbp], 1
	jmp	.L37
.L43:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC8[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	jmp	.L37
.L41:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L37
.L39:
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -28[rbp], eax
	jmp	.L37
.L38:
	mov	DWORD PTR -24[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -40[rbp], rax
	jmp	.L37
.L42:
	mov	eax, 0
	jmp	.L53
.L37:
	mov	rcx, QWORD PTR -96[rbp]
	mov	eax, DWORD PTR -84[rbp]
	lea	rdx, .LC10[rip]
	mov	rsi, rcx
	mov	edi, eax
	call	getopt@PLT
	mov	DWORD PTR -48[rbp], eax
	cmp	DWORD PTR -48[rbp], -1
	jne	.L45
	mov	eax, DWORD PTR -28[rbp]
	mov	edi, eax
	call	srand@PLT
	mov	DWORD PTR -44[rbp], 0
	cmp	DWORD PTR -20[rbp], 0
	je	.L46
	mov	eax, 0
	call	getRandomDouble
	movq	rax, xmm0
	mov	QWORD PTR -72[rbp], rax
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	lea	rdi, .LC3[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L47
.L46:
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -8[rbp], rax
	jne	.L48
	lea	rdi, .LC11[rip]
	call	puts@PLT
	lea	rdx, -72[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	readDouble
	mov	DWORD PTR -44[rbp], eax
	jmp	.L47
.L48:
	lea	rdx, -72[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	readDouble
	mov	DWORD PTR -44[rbp], eax
.L47:
	cmp	DWORD PTR -44[rbp], 1
	jne	.L49
	lea	rdi, .LC12[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L53
.L49:
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	call	validateNumber
	mov	DWORD PTR -44[rbp], eax
	cmp	DWORD PTR -44[rbp], 0
	jne	.L50
	lea	rdi, .LC13[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L53
.L50:
	mov	rax, QWORD PTR -72[rbp]
	movq	xmm0, rax
	call	calculate
	movq	rax, xmm0
	mov	QWORD PTR -56[rbp], rax
	cmp	DWORD PTR -24[rbp], 0
	je	.L51
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC14[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rdx, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	call	measureTime
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	mov	rsi, rax
	lea	rdi, .LC15[rip]
	mov	eax, 0
	call	printf@PLT
.L51:
	mov	rdx, QWORD PTR -56[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	call	printDouble
	mov	DWORD PTR -44[rbp], eax
	cmp	DWORD PTR -44[rbp], 0
	je	.L52
	lea	rdi, .LC16[rip]
	call	puts@PLT
.L52:
	mov	eax, 0
.L53:
	leave
	ret
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
