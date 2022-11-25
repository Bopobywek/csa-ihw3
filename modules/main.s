	.intel_syntax noprefix
	.text
	.section	.rodata
.LC3:
	.string	"%lf\n"
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
	push	rbp							# /
	mov	rbp, rsp						# | Пролог функции
	sub	rsp, 96							# |
	
	mov	DWORD PTR -84[rbp], edi			# | rbp[-84] := edi = argc
	mov	QWORD PTR -96[rbp], rsi			# | rbp[-96] := rsi = argv
	mov	rax, QWORD PTR stdin[rip]		# | rax := rip[stdin]
	mov	QWORD PTR -8[rbp], rax			# | input = rbp[-8] := rax = stdin // FILE *input = stdin 
	mov	rax, QWORD PTR stdout[rip]		# | rax := rip[stdout]
	mov	QWORD PTR -16[rbp], rax			# | output = rbp[-16] := rax = stdout // FILE *output = stdout
	mov	DWORD PTR -20[rbp], 0			# | random_flag = rbp[-20] := 0
	mov	DWORD PTR -24[rbp], 0			# | test_flag = rbp[-24] := 0
	mov	DWORD PTR -28[rbp], 42			# | seed = rbp[-28] := 42
	mov	QWORD PTR -40[rbp], 0			# | sample_size = rbp[-40] := 0
	
	jmp	.L37							# | Переходим к проверке условия продолжения цикла
.L45:
	# Это switch
	# Сравнивается opt (rbp[-48]) и коды символов-опций
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
.L40:									# | case 'r'
	mov	DWORD PTR -20[rbp], 1			# | random_flag = rbp[-20] := 1
	jmp	.L37							# | Переходим к проверке условия продолжения цикла
.L43:									# | case 'i'
	mov	rax, QWORD PTR optarg[rip]		# | rax := rip[optarg]
	lea	rsi, .LC8[rip]					# | rsi := &rip[.LC8]
	mov	rdi, rax						# | rdi := rax = rip[optarg]
	call	fopen@PLT					# | Вызываем fopen(rdi=rip[optarg], rsi=&rip[.LC8])
										# | Функция вернула результат через rax
	mov	QWORD PTR -8[rbp], rax			# | input = rbp[-8] := rax 
	jmp	.L37							# | Переходим к проверке условия продолжения цикла
.L41:									# | case 'o'
	mov	rax, QWORD PTR optarg[rip]		# | rax := rip[optarg]
	lea	rsi, .LC9[rip]					# | rsi := &rip[.LC9]
	mov	rdi, rax						# | rdi := rax = rip[optarg]
	call	fopen@PLT					# | Вызываем fopen(rdi=rip[optarg], rsi=&rip[.LC9])
										# | Функция вернула результат через rax
	mov	QWORD PTR -16[rbp], rax			# | output = rbp[-16] := rax
	jmp	.L37							# | Переходим к проверке условия продолжения цикла
.L39:									# | case 's'
	mov	rax, QWORD PTR optarg[rip]		# | rax := rip[optarg]
	mov	rdi, rax						# | rdi := rax = rip[optarg]
	call	atoi@PLT					# | Вызываем atoi(rdi=rip[optarg])
										# | Функция вернула результат через eax
	mov	DWORD PTR -28[rbp], eax			# | seed = rbp[-28] := eax
	jmp	.L37							# | Переходим к проверке условия продолжения цикла
.L38:									# | case 't'
	mov	DWORD PTR -24[rbp], 1			# | test_flag = rbp[-24] := 1
	mov	rax, QWORD PTR optarg[rip]		# | rax := rip[optarg]
	mov	rdi, rax						# | rdi := rax = rip[optarg]
	call	atoll@PLT					# | Вызываем atoll(rdi=rip[optarg])
										# | Функция вернула результат через rax
	mov	QWORD PTR -40[rbp], rax			# | sample_size = rbp[-40] := rax
	jmp	.L37							# | Переходим к проверке условия продолжения цикла
.L42:									
	mov	eax, 0							# | Возвращаем 0 через eax
	jmp	.L53							# | Переходим к эпилогу
.L37:									
	mov	rcx, QWORD PTR -96[rbp]			# | rcx := rbp[-96] = argv
	mov	eax, DWORD PTR -84[rbp]			# | eax := rbp[-84] = argc
	lea	rdx, .LC10[rip]					# | rdx := &rip[.LC10] -- адрес начала строки с опциями (3 аргумент для вызова getopt)
	mov	rsi, rcx						# | rsi := rcx = argv
	mov	edi, eax						# | edi := eax = argc
	call	getopt@PLT					# | Вызываем getopt(edi=argc, rsi=argv, rdx=&rip[.LC10])
										# | Функция через eax вернула значение
	mov	DWORD PTR -48[rbp], eax			# | opt = rbp[-48] := eax
	cmp	DWORD PTR -48[rbp], -1			# | Сравниваем opt (rbp[-48]) и -1
	jne	.L45							# | Если opt != - 1, переходим к телу цикла
	mov	eax, DWORD PTR -28[rbp]			# | eax := rbp[-28] = seed
	mov	edi, eax						# | edi := eax = seed -- первый аргумент
	call	srand@PLT					# | Вызываем srand(edi=seed)
	mov	DWORD PTR -44[rbp], 0			# | status_code = rbp[-44] := 0
	cmp	DWORD PTR -20[rbp], 0			# | Сравниваем random_flag (rbp[-20]) и 0 
	je	.L46							# | Если random_flag == 0, выражение ложно, переходим к else if
	mov	eax, 0							# | Иначе eax := 0
	call	getRandomDouble				# | Вызываем getRandomDouble()
										# | Функция вернула значение через xmm0
	movq	rax, xmm0					# | rax := xmm0
	mov	QWORD PTR -64[rbp], rax			# | number = rbp[-64] := rax = getRandomDouble()
	mov	rax, QWORD PTR -64[rbp]			# | rax := rbp[-64] = number
	movq	xmm0, rax					# | xmm0 := rax = number
	lea	rdi, .LC3[rip]					# | rdi := &rip[.LC3] -- адрес на начало форматной строки (первый аргумент)
	mov	eax, 1							# | eax := 1
	call	printf@PLT					# | Вызываем printf(rdi=&rip[.LC3], xmm0=number)
	jmp	.L47							# | Переходим на метку .L47
.L46:
	mov	rax, QWORD PTR stdin[rip]		# | rax := rip[stdin] = stdin
	cmp	QWORD PTR -8[rbp], rax			# | Сравниваем input (rbp[-8]) и stdin (rax)
	jne	.L48							# | Если input != stdin, переходим к else
	lea	rdi, .LC11[rip]					# | rdi := &rip[.LC11] -- первый аргумент, адрес на начало строки
	call	puts@PLT					# | Вызываем puts(rdi=&rip[.LC11])
	lea	rdx, -64[rbp]					# | rdx := &rbp[-64] = rbp - 64 = &number
	mov	rax, QWORD PTR -8[rbp]			# | rax := rbp[-8] = input
	mov	rsi, rdx						# | rsi := rdx = &number -- второй аргумент для вызова функции
	mov	rdi, rax						# | rdi := rax = input -- первый аргумент
	call	readDouble					# | Вызываем readDouble(rdi=input, rsi=&number)
										# | Функция возвращает значение через eax
	mov	DWORD PTR -44[rbp], eax			# | status_code = rbp[-44] := eax = readDouble(input, &number)
	jmp	.L47							# | Переходим на метку .L47
.L48:
	lea	rdx, -64[rbp]					# | rdx := &rbp[-64] = rbp - 64 = &number
	mov	rax, QWORD PTR -8[rbp]			# | rax := rbp[-8] = input
	mov	rsi, rdx						# | rsi := rdx = &number -- второй аргумент для вызова функции
	mov	rdi, rax						# | rdi := rax = input -- первый аргумент
	call	readDouble					# | Вызываем readDouble(rdi=input, rsi=&number)
										# | Функция возвращает значение через eax
	mov	DWORD PTR -44[rbp], eax			# | status_code = rbp[-44] := eax = readDouble(input, &number)
.L47:
	cmp	DWORD PTR -44[rbp], 1			# | Сравниваем status_code (rbp[-44]) и 1
	jne	.L49							# | Если status_code != 1, переходим на метку .L49
	lea	rdi, .LC12[rip]					# | rdi := &rip[.LC12] -- адрес на начало строкиц для вывода (первый аргумент)
	call	puts@PLT					# | Вызываем puts(rdi=&rip[.LC12])
	mov	eax, 0							# | Возвращаем 0 через eax
	jmp	.L53							# | Переходим к эпилогу
.L49:
	mov	rax, QWORD PTR -64[rbp]			# | rax := rbp[-64] = number
	movq	xmm0, rax					# | xmm0 := rax = number -- первый аргумент
	call	validateNumber				# | Вызываем validateNumber(xmm0=number)
										# | Функция возвращает значение через eax
	mov	DWORD PTR -44[rbp], eax			# | status_code = rbp[-44] := eax = validateNumber(number) 
	cmp	DWORD PTR -44[rbp], 0			# | Сравниваем status_code (rbp[-44]) и 0
	jne	.L50							# | Если status_code != 0, переходим на метку .L50
	lea	rdi, .LC13[rip]					# | rdi := &rip[LC13] -- адрес на начало строки для вывода (первый аргумент)
	call	puts@PLT					# | Вызываем puts(rdi=&rip[LC13])
	mov	eax, 0							# | Возвращаем 0 через eax
	jmp	.L53							# | И переходим к эпилогу
.L50:							
	mov	rax, QWORD PTR -64[rbp]			# | rax := rbp[-64] = number
	movq	xmm0, rax					# | xmm0 := rax = number -- первый аргумент для вызова функции
	call	calculate					# | Вызываем calculate(xmm0=number)
										# | Функция вернула значение через xmm0
	movq	rax, xmm0					# | rax := xmm0
	mov	QWORD PTR -72[rbp], rax			# | result = rbp[-72] := rax
	cmp	DWORD PTR -24[rbp], 0			# | Сравниваем test_flag (rbp[-24]) и 0
	je	.L51							# | Если test_flag == 0, переходим на метку .L51
	mov	rax, QWORD PTR -40[rbp]			# | rax := rbp[-40] = sample_size
	mov	rsi, rax						# | rsi := rax = sample_size -- второй аргумент для вызова функции
	lea	rdi, .LC14[rip]					# | rdi := &rip[.LC14] -- адрес на начало строки для вывода (первый аргумент)
	mov	eax, 0							# | eax := 0
	call	printf@PLT					# | Вызываем printf(rdi=&rip[.LC14], rsi=sample_size)
	mov	rdx, QWORD PTR -64[rbp]			# | rdx := rbp[-64] = number
	lea rcx, -72[rbp]					# | rcx := &rbp[-72] = &result
	mov	rax, QWORD PTR -40[rbp]			# | rax := rbp[-40] = sample_size
	mov rsi, rcx						# | rsi := rcx = &result -- третий аргумент 
	movq	xmm0, rdx					# | xmm0 := rdx = number -- второй аргумент
	mov	rdi, rax						# | rdi := rax = sample_size -- первый аргумент
	call	measureTime					# | Вызываем measureTime(rdi=sample_size, xmm0=number, rsi=&result)
										# | Функция вернула значение через rax
	mov	QWORD PTR -56[rbp], rax			# | elapsed = rbp[-56] := rax
	mov	rax, QWORD PTR -56[rbp]			# | rax := rbp[-56] = elapsed
	mov	rsi, rax						# | rsi := rax = elapsed -- второй аргумент для printf
	lea	rdi, .LC15[rip]					# | rdi := &rip[.LC15] -- адрес начала форматной строки (первый аргумент)
	mov	eax, 0							# | eax := 0
	call	printf@PLT					# | Вызываем printf(rdi=&rip[.LC15], rsi=elapsed)
.L51:			
	mov	rdx, QWORD PTR -72[rbp]			# | rdx := rbp[-72] = result
	mov	rax, QWORD PTR -16[rbp]			# | rax := rbp[-16] = output
	movq	xmm0, rdx					# | xmm0 := rdx = result -- второй аргумент
	mov	rdi, rax						# | rdi := rax = output -- первый аргумент
	call	printDouble					# | Вызываем printDouble(rdi=output, xmm0=result)
										# | Функция вернула значение через eax
	mov	DWORD PTR -44[rbp], eax			# | status_code = rbp[-44] = eax
	cmp	DWORD PTR -44[rbp], 0			# | Сравниваем status_code (rbp[-44]) и 0
	je	.L52							# | Если status_code == 0, переходим на метку .L52
	lea	rdi, .LC16[rip]					# | rdi := &rip[.LC16] -- адрес на начало строки для вывода (первый аргумент)
	call	puts@PLT					# | Вызываем puts(rdi=&rip[.LC16])
.L52:
	mov	eax, 0							# | Возвращаем 0 через eax
.L53:
	leave								# | Эпилог функции
	ret									# \
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
