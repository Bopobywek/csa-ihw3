	.file	"solution.c"
	.text
	.p2align 4
	.globl	calculate
	.type	calculate, @function
calculate:
.LFB50:
	.cfi_startproc
	endbr64
	movsd	EPS(%rip), %xmm6
	movapd	%xmm0, %xmm1
	movl	$2, %edx
	movq	.LC1(%rip), %xmm7
	pxor	%xmm3, %xmm3
	movapd	%xmm6, %xmm5
	xorpd	%xmm7, %xmm5
	jmp	.L2
	.p2align 4,,10
	.p2align 3
.L3:
	leaq	-1(%rdx), %rax
	pxor	%xmm2, %xmm2
	pxor	%xmm4, %xmm4
	cvtsi2sdq	%rdx, %xmm4
	addsd	%xmm1, %xmm3
	mulsd	%xmm0, %xmm1
	addq	$1, %rdx
	cvtsi2sdq	%rax, %xmm2
	divsd	%xmm4, %xmm2
	mulsd	%xmm2, %xmm1
.L2:
	comisd	%xmm1, %xmm5
	ja	.L3
	comisd	%xmm6, %xmm1
	ja	.L3
	xorpd	%xmm7, %xmm3
	movapd	%xmm3, %xmm0
	ret
	.cfi_endproc
.LFE50:
	.size	calculate, .-calculate
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"%lf"
	.text
	.p2align 4
	.globl	readDouble
	.type	readDouble, @function
readDouble:
.LFB51:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	je	.L9
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rsi, %rdx
	leaq	.LC2(%rip), %rsi
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L9:
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE51:
	.size	readDouble, .-readDouble
	.section	.rodata.str1.1
.LC3:
	.string	"%lf\n"
	.text
	.p2align 4
	.globl	printDouble
	.type	printDouble, @function
printDouble:
.LFB52:
	.cfi_startproc
	endbr64
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.L19
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC3(%rip), %rdx
	movl	$1, %esi
	call	__fprintf_chk@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L19:
	ret
	.cfi_endproc
.LFE52:
	.size	printDouble, .-printDouble
	.p2align 4
	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
.LFB53:
	.cfi_startproc
	endbr64
	movsd	.LC4(%rip), %xmm1
	comisd	%xmm0, %xmm1
	jb	.L27
	xorl	%eax, %eax
	comisd	.LC5(%rip), %xmm0
	setnb	%al
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE53:
	.size	validateNumber, .-validateNumber
	.p2align 4
	.globl	max
	.type	max, @function
max:
.LFB54:
	.cfi_startproc
	endbr64
	cmpl	%esi, %edi
	movl	%esi, %eax
	cmovge	%edi, %eax
	ret
	.cfi_endproc
.LFE54:
	.size	max, .-max
	.p2align 4
	.globl	min
	.type	min, @function
min:
.LFB55:
	.cfi_startproc
	endbr64
	minsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE55:
	.size	min, .-min
	.p2align 4
	.globl	getRandomDouble
	.type	getRandomDouble, @function
getRandomDouble:
.LFB56:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	rand@PLT
	movl	$1, %edx
	pxor	%xmm0, %xmm0
	movsd	.LC4(%rip), %xmm1
	testl	%eax, %eax
	cmovle	%edx, %eax
	subl	$1, %eax
	cvtsi2sdl	%eax, %xmm0
	divsd	.LC6(%rip), %xmm0
	addsd	%xmm0, %xmm0
	subsd	.LC7(%rip), %xmm0
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	minsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE56:
	.size	getRandomDouble, .-getRandomDouble
	.p2align 4
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
.LFB57:
	.cfi_startproc
	endbr64
	movabsq	$4835703278458516699, %r8
	movq	%rsi, %rax
	movq	%rdx, %r10
	sarq	$63, %rsi
	imulq	%r8
	movq	%rcx, %rax
	sarq	$63, %rcx
	imulq	$1000, %rdi, %r9
	imulq	$1000, %r10, %r10
	sarq	$18, %rdx
	subq	%rsi, %rdx
	leaq	(%r9,%rdx), %rdi
	imulq	%r8
	movq	%rdi, %rax
	sarq	$18, %rdx
	subq	%rcx, %rdx
	addq	%rdx, %r10
	subq	%r10, %rax
	ret
	.cfi_endproc
.LFE57:
	.size	getTimeDiff, .-getTimeDiff
	.p2align 4
	.globl	measureTime
	.type	measureTime, @function
measureTime:
.LFB58:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%rdi, 8(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	jle	.L45
	movapd	%xmm0, %xmm5
	movq	%rsi, %r13
	xorl	%ebx, %ebx
	xorl	%r12d, %r12d
	leaq	16(%rsp), %r15
	leaq	32(%rsp), %r14
	movabsq	$4835703278458516699, %rbp
	.p2align 4,,10
	.p2align 3
.L43:
	movq	%r15, %rsi
	movl	$1, %edi
	movsd	%xmm5, (%rsp)
	call	clock_gettime@PLT
	movsd	(%rsp), %xmm5
	movl	$2, %edx
	movsd	EPS(%rip), %xmm6
	pxor	%xmm2, %xmm2
	movapd	%xmm6, %xmm4
	movapd	%xmm5, %xmm0
	xorpd	.LC1(%rip), %xmm4
	jmp	.L41
	.p2align 4,,10
	.p2align 3
.L42:
	leaq	-1(%rdx), %rax
	pxor	%xmm1, %xmm1
	pxor	%xmm3, %xmm3
	cvtsi2sdq	%rdx, %xmm3
	addsd	%xmm0, %xmm2
	mulsd	%xmm5, %xmm0
	addq	$1, %rdx
	cvtsi2sdq	%rax, %xmm1
	divsd	%xmm3, %xmm1
	mulsd	%xmm1, %xmm0
.L41:
	comisd	%xmm0, %xmm4
	ja	.L42
	comisd	%xmm6, %xmm0
	ja	.L42
	xorpd	.LC1(%rip), %xmm2
	movq	%r14, %rsi
	movl	$1, %edi
	movsd	%xmm5, (%rsp)
	addq	$1, %rbx
	movsd	%xmm2, 0(%r13)
	call	clock_gettime@PLT
	movq	40(%rsp), %rsi
	movsd	(%rsp), %xmm5
	imulq	$1000, 32(%rsp), %rcx
	imulq	$1000, 16(%rsp), %rdi
	movq	%rsi, %rax
	sarq	$63, %rsi
	imulq	%rbp
	sarq	$18, %rdx
	subq	%rsi, %rdx
	movq	24(%rsp), %rsi
	addq	%rdx, %rcx
	movq	%rsi, %rax
	sarq	$63, %rsi
	imulq	%rbp
	sarq	$18, %rdx
	subq	%rsi, %rdx
	addq	%rdi, %rdx
	subq	%rdx, %rcx
	addq	%rcx, %r12
	cmpq	%rbx, 8(%rsp)
	jne	.L43
.L39:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L48
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L45:
	.cfi_restore_state
	xorl	%r12d, %r12d
	jmp	.L39
.L48:
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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB59:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movl	$42, %r15d
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	xorl	%r13d, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	%edi, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	.L54(%rip), %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	stdin(%rip), %r14
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movq	stdout(%rip), %rax
	movq	$0, 24(%rsp)
	movl	$0, 20(%rsp)
	movq	%rax, 8(%rsp)
.L50:
	leaq	.LC10(%rip), %rdx
	movq	%rbp, %rsi
	movl	%r12d, %edi
	call	getopt@PLT
	cmpl	$-1, %eax
	je	.L88
	cmpl	$63, %eax
	je	.L51
	subl	$105, %eax
	cmpl	$11, %eax
	ja	.L50
	movslq	(%rbx,%rax,4), %rax
	addq	%rbx, %rax
	notrack jmp	*%rax
	.section	.rodata
	.align 4
	.align 4
.L54:
	.long	.L58-.L54
	.long	.L50-.L54
	.long	.L50-.L54
	.long	.L50-.L54
	.long	.L50-.L54
	.long	.L50-.L54
	.long	.L57-.L54
	.long	.L50-.L54
	.long	.L50-.L54
	.long	.L56-.L54
	.long	.L55-.L54
	.long	.L53-.L54
	.section	.text.startup
.L56:
	movl	$1, %r13d
	jmp	.L50
.L57:
	movq	optarg(%rip), %rdi
	leaq	.LC9(%rip), %rsi
	call	fopen@PLT
	movq	%rax, 8(%rsp)
	jmp	.L50
.L58:
	movq	optarg(%rip), %rdi
	leaq	.LC8(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %r14
	jmp	.L50
.L53:
	movq	optarg(%rip), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtoll@PLT
	movl	$1, 20(%rsp)
	movq	%rax, 24(%rsp)
	jmp	.L50
.L55:
	movq	optarg(%rip), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, %r15d
	jmp	.L50
.L64:
	leaq	.LC13(%rip), %rdi
	call	puts@PLT
	.p2align 4,,10
	.p2align 3
.L51:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L89
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L88:
	.cfi_restore_state
	movl	%r15d, %edi
	call	srand@PLT
	testl	%r13d, %r13d
	jne	.L90
	cmpq	%r14, stdin(%rip)
	je	.L91
	testq	%r14, %r14
	je	.L63
.L87:
	leaq	40(%rsp), %rdx
	leaq	.LC2(%rip), %rsi
	movq	%r14, %rdi
	xorl	%eax, %eax
	call	__isoc99_fscanf@PLT
.L61:
	movsd	40(%rsp), %xmm4
	movsd	.LC4(%rip), %xmm0
	comisd	%xmm4, %xmm0
	jb	.L64
	comisd	.LC5(%rip), %xmm4
	jb	.L64
	movsd	EPS(%rip), %xmm6
	movapd	%xmm4, %xmm0
	movl	$2, %edx
	movq	.LC1(%rip), %xmm7
	pxor	%xmm2, %xmm2
	movapd	%xmm6, %xmm5
	xorpd	%xmm7, %xmm5
	jmp	.L67
	.p2align 4,,10
	.p2align 3
.L68:
	leaq	-1(%rdx), %rax
	pxor	%xmm1, %xmm1
	pxor	%xmm3, %xmm3
	cvtsi2sdq	%rdx, %xmm3
	addsd	%xmm0, %xmm2
	mulsd	%xmm4, %xmm0
	addq	$1, %rdx
	cvtsi2sdq	%rax, %xmm1
	divsd	%xmm3, %xmm1
	mulsd	%xmm1, %xmm0
.L67:
	comisd	%xmm0, %xmm5
	ja	.L68
	comisd	%xmm6, %xmm0
	ja	.L68
	xorpd	%xmm7, %xmm2
	cmpl	$0, 20(%rsp)
	movsd	%xmm2, 48(%rsp)
	jne	.L92
.L69:
	movq	8(%rsp), %rax
	testq	%rax, %rax
	je	.L70
	movsd	48(%rsp), %xmm0
	movq	%rax, %rdi
	movl	$1, %esi
	leaq	.LC3(%rip), %rdx
	movl	$1, %eax
	call	__fprintf_chk@PLT
	jmp	.L51
.L90:
	xorl	%eax, %eax
	call	getRandomDouble
	movl	$1, %edi
	movl	$1, %eax
	leaq	.LC3(%rip), %rsi
	movsd	%xmm0, 40(%rsp)
	call	__printf_chk@PLT
	jmp	.L61
.L91:
	leaq	.LC11(%rip), %rdi
	call	puts@PLT
	testq	%r14, %r14
	jne	.L87
.L63:
	leaq	.LC12(%rip), %rdi
	call	puts@PLT
	jmp	.L51
.L92:
	movq	24(%rsp), %rbx
	leaq	.LC14(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	movq	%rbx, %rdx
	call	__printf_chk@PLT
	movsd	40(%rsp), %xmm0
	leaq	48(%rsp), %rsi
	movq	%rbx, %rdi
	call	measureTime
	leaq	.LC15(%rip), %rsi
	movl	$1, %edi
	movq	%rax, %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L69
.L70:
	leaq	.LC16(%rip), %rdi
	call	puts@PLT
	jmp	.L51
.L89:
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
