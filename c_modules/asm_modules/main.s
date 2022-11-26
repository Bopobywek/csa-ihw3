	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"w"
.LC2:
	.string	"rt:s:i:o:"
.LC3:
	.string	"%lf\n"
	.align 8
.LC4:
	.string	"Enter a real number in range [-1; 1):"
	.align 8
.LC5:
	.string	"Error! The input file could not be read."
	.align 8
.LC6:
	.string	"Error! The input number is not in the specified range."
	.align 8
.LC7:
	.string	"Running current test case %ld times...\n"
.LC8:
	.string	"Elapsed time: %ld ms\n"
	.align 8
.LC9:
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
	jmp	.L2
.L10:
	cmp	DWORD PTR -48[rbp], 116
	je	.L3
	cmp	DWORD PTR -48[rbp], 116
	jg	.L2
	cmp	DWORD PTR -48[rbp], 115
	je	.L4
	cmp	DWORD PTR -48[rbp], 115
	jg	.L2
	cmp	DWORD PTR -48[rbp], 114
	je	.L5
	cmp	DWORD PTR -48[rbp], 114
	jg	.L2
	cmp	DWORD PTR -48[rbp], 111
	je	.L6
	cmp	DWORD PTR -48[rbp], 111
	jg	.L2
	cmp	DWORD PTR -48[rbp], 63
	je	.L7
	cmp	DWORD PTR -48[rbp], 105
	je	.L8
	jmp	.L2
.L5:
	mov	DWORD PTR -20[rbp], 1
	jmp	.L2
.L8:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	jmp	.L2
.L6:
	mov	rax, QWORD PTR optarg[rip]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	jmp	.L2
.L4:
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -28[rbp], eax
	jmp	.L2
.L3:
	mov	DWORD PTR -24[rbp], 1
	mov	rax, QWORD PTR optarg[rip]
	mov	rdi, rax
	call	atoll@PLT
	mov	QWORD PTR -40[rbp], rax
	jmp	.L2
.L7:
	mov	eax, 0
	jmp	.L18
.L2:
	mov	rcx, QWORD PTR -96[rbp]
	mov	eax, DWORD PTR -84[rbp]
	lea	rdx, .LC2[rip]
	mov	rsi, rcx
	mov	edi, eax
	call	getopt@PLT
	mov	DWORD PTR -48[rbp], eax
	cmp	DWORD PTR -48[rbp], -1
	jne	.L10
	mov	eax, DWORD PTR -28[rbp]
	mov	edi, eax
	call	srand@PLT
	mov	DWORD PTR -44[rbp], 0
	cmp	DWORD PTR -20[rbp], 0
	je	.L11
	mov	eax, 0
	call	getRandomDouble@PLT
	movq	rax, xmm0
	mov	QWORD PTR -64[rbp], rax
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	lea	rdi, .LC3[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L12
.L11:
	mov	rax, QWORD PTR stdin[rip]
	cmp	QWORD PTR -8[rbp], rax
	jne	.L13
	lea	rdi, .LC4[rip]
	call	puts@PLT
	lea	rdx, -64[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	readDouble@PLT
	mov	DWORD PTR -44[rbp], eax
	jmp	.L12
.L13:
	lea	rdx, -64[rbp]
	mov	rax, QWORD PTR -8[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	readDouble@PLT
	mov	DWORD PTR -44[rbp], eax
.L12:
	cmp	DWORD PTR -44[rbp], 1
	jne	.L14
	lea	rdi, .LC5[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L18
.L14:
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	call	validateNumber@PLT
	mov	DWORD PTR -44[rbp], eax
	cmp	DWORD PTR -44[rbp], 0
	jne	.L15
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L18
.L15:
	mov	rax, QWORD PTR -64[rbp]
	movq	xmm0, rax
	call	calculate@PLT
	movq	rax, xmm0
	mov	QWORD PTR -72[rbp], rax
	cmp	DWORD PTR -24[rbp], 0
	je	.L16
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC7[rip]
	mov	eax, 0
	call	printf@PLT
	mov	rdx, QWORD PTR -64[rbp]
	lea	rcx, -72[rbp]
	mov	rax, QWORD PTR -40[rbp]
	mov	rsi, rcx
	movq	xmm0, rdx
	mov	rdi, rax
	call	measureTime@PLT
	mov	QWORD PTR -56[rbp], rax
	mov	rax, QWORD PTR -56[rbp]
	mov	rsi, rax
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
.L16:
	mov	rdx, QWORD PTR -72[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rdx
	mov	rdi, rax
	call	printDouble@PLT
	mov	DWORD PTR -44[rbp], eax
	cmp	DWORD PTR -44[rbp], 0
	je	.L17
	lea	rdi, .LC9[rip]
	call	puts@PLT
.L17:
	mov	eax, 0
.L18:
	leave
	ret
	.size	main, .-main
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
