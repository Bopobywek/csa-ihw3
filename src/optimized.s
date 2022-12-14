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
	push	rbp                         # / Пролог функции
	mov	rbp, rsp                        # |

	movsd	xmm8, xmm0    				# | xmm8 := xmm0 = double x -- загружаем в регистр первый аргумент, переданный через xmm0
	pxor	xmm9, xmm9     				# | В xmm9 будем хранить result. Обнуляем его
	movsd	xmm10, xmm8    				# | component = xmm10 := xmm8 = x
	mov	r11, 2           				# | i = r11 := 2
	jmp	.L2                             # | Переходим к проверке условия продолжения цикла (метка .L2)
.L3:
	addsd	xmm9, xmm10					# | result = xmm9 := xmm9 + xmm10 = result + component
	mulsd	xmm10, xmm8					# | xmm10 := xmm10 * xmm8 = component * x
	mov	rax, r11						# | rax := r11 = i
	sub	rax, 1							# | rax := rax - 1 = i - 1
	cvtsi2sd	xmm0, rax				# | Конвертируем i - 1 (rax) в число с плавающей точкой двойной точности и кладем в xmm0
	cvtsi2sd	xmm1, r11  				# | Конвертируем i (r11) в число с плавающей точкой двойной точности и кладем в xmm1
	divsd	xmm0, xmm1					# | xmm0 := xmm0 / xmm1 = (i-1) / i
	mulsd	xmm10, xmm0					# | component = xmm10 := xmm10 * xmm0 = component * (i-1) / i
	add	r11, 1							# | ++i
.L2:
	movsd	xmm0, QWORD PTR EPS[rip]	# | xmm0 := rip[EPS] = EPS
	movq	xmm1, QWORD PTR .LC1[rip]	# | xmm1 := rip[.LC1] -- маска, для получения отрицательного числ
	xorpd	xmm0, xmm1					# | Накладывая маску на xmm0, получаем в старшем бите 1 => xmm0 := xmm0 ^ xmm1 = -EPS
	comisd	xmm0, xmm10					# | Сравниваем -EPS (xmm0) и component (xmm10)
	ja	.L3								# | Если -EPS > component, переходим к телу цикла
	movsd	xmm1, QWORD PTR EPS[rip]	# | xmm1 := rip[EPS] = EPS
	comisd	xmm10, xmm1					# | Сравниваем component (xmm10) и EPS (xmm1)
	ja	.L3								# | Если component > EPS, переходим к телу цикла
	movsd	xmm0, xmm9					# | xmm0 := xmm9 = result
	movq	xmm1, QWORD PTR .LC1[rip]	# | xmm1 := rip[.LC1] -- маска, для получения отрицательного числа
	xorpd	xmm0, xmm1					# | Накладывая маску на xmm0, получаем в старшем бите 1 => xmm0 := xmm0 ^ xmm1 = -result
										# | Результат возвращаем через xmm0
								
	pop	rbp								# | Эпилог функции
	ret									# \
	.size	calculate, .-calculate

# ^
# Удалось полностью заменить хранение локальных переменных на стеке хранением локальных переменных в регистрах
# Для чисел типа double использовались регистры xmm8, xmm9 и xmm10. Для целого числа i был использован регистр r11

	.section	.rodata
.LC2:
	.string	"%lf"
	.text
	.globl	readDouble
	.type	readDouble, @function
readDouble:
	push	rbp							# /
	mov	rbp, rsp						# | Пролог функции
	sub	rsp, 16							# |
	
	mov	r12, rdi						# | r12 := rdi = FILE *stream -- загружаем в регистр первый переданный параметр через rdi
	mov	r13, rsi						# | r13 := rsi = double *result -- загружаем в регистр второй переданный параметр через rsi
	cmp	r12, 0							# | Сравниваем stream (r12) и NULL (0)
	jne	.L6								# | Если stream != NULL, переходим на метку .L6
	mov	eax, 1							# | Иначе возвращаем 1 через eax
	jmp	.L7								# | и переходим к эпилогу
.L6:
	mov	rdx, r13						# | rdx := r13 = result -- третий аргумент для вызова fscanf
	lea	rsi, .LC2[rip]					# | rsi := &rip[.LC2] -- второй аргумент (форматная строка) для вызова 
	mov	rdi, r12						# | rdi := r12 = stream -- первый аргумент для вызова
	mov	eax, 0							# | eax := 0 
	call	__isoc99_fscanf@PLT			# | Вызываем fscanf(rdi=stream, rsi=&rip[.LC2], rdx=result)
	mov	eax, 0							# | Возвращаем 0 через eax
.L7:		
	leave								# | Эпилог функции
	ret									# \
	.size	readDouble, .-readDouble
# ^
# Использование стека было заменено на следующие регистры: r12, r13

	.section	.rodata
.LC3:
	.string	"%lf\n"
	.text
	.globl	printDouble
	.type	printDouble, @function
printDouble:
	push	rbp							# /
	mov	rbp, rsp						# | Пролог функции
	sub	rsp, 16							# |
	
	mov	r12, rdi						# | r12 := rdi = FILE *stream -- загружаем в регистр первый аргумент, переданный через rdi
										# | Также через xmm0 был передан второй аргумент: double number
	cmp	r12, 0							# | Сравниваем stream (r12) и NULL (0)
	jne	.L9								# | Если stream != NULL, переходим на метку .L9
	mov	eax, 1							# | Иначе возвращаем 1 через eax
	jmp	.L10							# | и переходим к эпилогу функции
.L9:
	lea	rsi, .LC3[rip]					# | rsi := &rip[.LC3]
	mov	rdi, r12						# | rdi := r12 = stream
	mov	eax, 1							# | eax := 1
										# | xmm0 не меняли, поэтому он так и передается
	call	fprintf@PLT					# | Вызываем fprintf(rdi=stream, rsi=&rip[.LC3], xmm0=number)
	mov	eax, 0							# | Возвращаем 0 через eax
.L10:
	leave								# | Эпилог функции
	ret									# \
	.size	printDouble, .-printDouble
# ^
# Использование стека было заменено на регистр r12. 
# Также было исключено лишнее сохранение на стек значения входного параметра double number

	.globl	validateNumber
	.type	validateNumber, @function
validateNumber:
	push	rbp							# / Пролог функции
	mov	rbp, rsp						# |
	
	movsd	xmm8, xmm0					# | xmm8 := xmm0 = double number -- загружаем в регистр первый переданный аргумент
	movsd	xmm0, QWORD PTR .LC4[rip]	# | xmm0 := rip[.LC4] = 0.999
	comisd	xmm0, xmm8					# | Сравниваем 0.999 (xmm0) и number (xmm8)
	jb	.L12							# | Если 0.999 < number, выражение ложно, переходим к возврату 0 на метку .L12
	movsd	xmm1, QWORD PTR .LC5[rip]	# | xmm1 := rip[.LC5] = -1.0
	comisd	xmm8, xmm1					# | Сравниваем number (xmm8) и -1.0 (xmm1)
	jb	.L12							# | Если number < -1.0, выражение ложно, переходим к возврату 0 на метку .L12
	mov	eax, 1							# | Иначе возвращаем 1 через eax
	jmp	.L16							# | и переходим к эпилогу
.L12:
	mov	eax, 0							# | Возвращаем 0 через eax
.L16:
	pop	rbp								# | Пролог функции 
	ret									# \
	.size	validateNumber, .-validateNumber
# ^
# Теперь храним number не на стеке, а в регистре xmm8
	
	.globl	max
	.type	max, @function
max:
	push	rbp							# / Пролог функции
	mov	rbp, rsp						# |
										
										# | Через edi и esi получаем переданные аргументы a и b соответственно
	cmp	edi, esi						# | Сравниваем a (edi) и b (esi)
	jle	.L20							# | Если a <= b, возвращаем b через eax
	mov	eax, edi						# | Иначе возвращаем a: eax := edi = a
	jmp	.L21							# | и переходим к эпилогу
.L20:
	mov	eax, esi						# | eax := esi = b
.L21:
	pop	rbp								# | Эпилог функции
	ret									# \
	.size	max, .-max
# ^
# Использование стека полностью заменено на использование регистров esi и edi

	.globl	min
	.type	min, @function
min:
	push	rbp							# / Пролог функции
	mov	rbp, rsp						# |
										
										# | Через xmm0 и xmm1 получаем переданные аргументы a и b соответственно
	comisd	xmm0, xmm1					# | Сравниваем a (xmm0) и b (xmm1)
	jbe	.L25							# | Если a <= b, возвращаем a через xmm0
	movsd	xmm0, xmm1					# | xmm0 := xmm1 = b // Иначе возвращаем b
	jmp	.L25							# | Переходим к эпилогу
.L25:
										# | Результат возвращается через xmm0
										
	pop	rbp								# | Эпилог функции
	ret									# \
	.size	min, .-min
# ^
# Использование стека полностью заменено на использование регистров xmm0 и xmm1
	
	.globl	getRandomDouble
	.type	getRandomDouble, @function
getRandomDouble:
	push	rbp							# /
	mov	rbp, rsp						# | Пролог функции
	sub	rsp, 16							# |
	
	call	rand@PLT					# | Вызываем rand()
										# | Функция вернула значение через eax
	mov	esi, 1							# | esi := 1 -- второй аргумент для вызова max
	mov	edi, eax						# | edi := eax = rand() -- первый аргумент
	call	max							# | Вызываем max(edi=rand(), esi=1)
										# | Функция вернула значение через eax
	sub	eax, 1							# | eax := eax - 1 = max(rand(), 1) - 1
	mov	ebx, eax						# | random = ebx := eax = max(rand(), 1) - 1
	cvtsi2sd	xmm0, ebx 				# | Конвертируем random (ebx) в число с плавающей точкой двойной точности и кладем в xmm0
	movsd	xmm1, QWORD PTR .LC6[rip]	# | xmm1 := rip[.LC6] = (double)RAND_MAX
	divsd	xmm0, xmm1					# | xmm0 := xmm0 / xmm1 = random / RAND_MAX
	addsd	xmm0, xmm0					# | xmm0 := xmm0 + xmm0 <=> xmm0 * 2 = random / RAND_MAX * 2
	movsd	xmm1, QWORD PTR .LC7[rip]	# | xmm1 := rip[.LC7] = 1.0
	subsd	xmm0, xmm1					# | xmm0 := xmm0 - xmm1 = xmm0 - 1.0 -- первый аргумент для вызова min
	movsd	xmm1, QWORD PTR .LC4[rip]	# | xmm1 := rip[.LC4] = 0.999 -- второй аргумент для вызова min
	call	min							# | Вызываем min(xmm0=random / RAND_MAX * 2.0 - 1.0, xmm1=0.999)
										# | Функция вернула значение через xmm0
										# | Результат тоже возвращаем через xmm0
	
	leave								# | Эпилог функции
	ret									# \
	.size	getRandomDouble, .-getRandomDouble
# ^ 
# Хранение в стеке заменено на хранение в регистре ebx
	
	.globl	getTimeDiff
	.type	getTimeDiff, @function
getTimeDiff:
	push	rbp							# / Пролог функции
	mov	rbp, rsp						# |
	
	mov	QWORD PTR -32[rbp], rdi			# | rbp[-32] := rsi = ts1.tv_sec
	mov	QWORD PTR -24[rbp], rsi			# | rbp[-24] := rsi = ts1.tv_nsec
	mov	QWORD PTR -48[rbp], rdx			# | rbp[-48] := rdx = ts2.tv_sec
	mov	QWORD PTR -40[rbp], rcx			# | rbp[-40] := rdx = ts2.tv_nsec
	
	mov	rax, QWORD PTR -32[rbp]			# | rax := rbp[-32] = ts1.tv_sec
	imul	rsi, rax, 1000				# | rsi := rax * 1000 = ts1.tv_sec * 1000
	mov	rcx, QWORD PTR -24[rbp]			# | rcx := rbp[-24] = ts1.tv_nsec
	movabs	rdx, 4835703278458516699 	# |  /
	mov	rax, rcx						# |  |
	imul	rdx							# |  |
	sar	rdx, 18							# |  | Какая-то сложная (и наверняка оптимальная по скорости) арифметика
	mov	rax, rcx						# |  |
	sar	rax, 63							# |  |
	sub	rdx, rax						# |  |
	mov	rax, rdx						# |  \
	add	rax, rsi						# | rax := rax + rsi
	mov	QWORD PTR -8[rbp], rax			# | rbp[-8] := rax = ts1_ms
	mov	rax, QWORD PTR -48[rbp]			# | rax := rbp[-48] = ts2.tv_sec
	imul	rsi, rax, 1000				# | rsi := rax * 1000
	mov	rcx, QWORD PTR -40[rbp]			# | rcx := rbp[-40] = ts2.tv_nsec
	movabs	rdx, 4835703278458516699 	# |  /
	mov	rax, rcx						# |  |
	imul	rdx							# |  |
	sar	rdx, 18							# |  |
	mov	rax, rcx						# |  | Какая-то сложная (и наверняка оптимальная по скорости) арифметика
	sar	rax, 63							# |  |
	sub	rdx, rax						# |  |
	mov	rax, rdx						# |  \
	add	rax, rsi						# | rax := rax + rsi
	mov	QWORD PTR -16[rbp], rax			# | rbp[-16] := rax = ts2_ms
	mov	rax, QWORD PTR -8[rbp]			# | rax := rbp[-8] = ts1_ms
	sub	rax, QWORD PTR -16[rbp]			# | rax := rax - rbp[-16] = ts1_ms - ts2_ms
										# | Возвращаем результат через rax
	
	pop	rbp								# | Эпилог функции
	ret									# \
	.size	getTimeDiff, .-getTimeDiff
	.globl	measureTime
	.type	measureTime, @function
measureTime:
	push	rbp							# /
	mov	rbp, rsp						# | Пролог функции
	sub	rsp, 80							# |
	
	mov	QWORD PTR -56[rbp], rdi			# | rbp[-56] := rdi = int64_t sample_size -- загружаем на стек первый переданный аргумент
	movq r13, xmm0						# | r13 := xmm0 = double number -- загружаем в регистр второй переданный аргумент
	mov r12, rsi						# | r12 := rsi = double *result -- загружаем в регистр третий аргумент 
	mov	r15, 0							# | elapsed = r15 := 0
	mov	r14, 0							# | i = r14 := 0
	jmp	.L33							# | Переходим к проверке условия продолжения цикла
.L34:
	lea	rsi, -32[rbp]					# | rsi := &rbp[-32] = &start -- второй аргумент для функции
	mov	edi, 1							# | edi := 1 = CLOCK_MONOTONIC -- первый аргумент для функции
	call	clock_gettime@PLT			# | Вызываем clock_gettime(edi=1, rsi=&start)
	movq	xmm0, r13					# | xmm0 := r13 = number -- первый аргумент (double) для передачи в функции
	call	calculate					# | Вызываем calculate(xmm0=number)
										# | Функция вернула значение через xmm0
	movq QWORD PTR [r12], xmm0			# | *result = [r12] := xmm0
	lea	rsi, -48[rbp]					# | rsi := &rbp[-48] = &end -- передаем второй аргумент
	mov	edi, 1							# | edi := 1 = CLOCK_MONOTONIC
	call	clock_gettime@PLT			# | Вызываем clock_gettime(edi=1, rsi=&end)
	mov	rax, QWORD PTR -32[rbp]			# | rax := rbp[-32] = start.tv_sec
	mov	rdx, QWORD PTR -24[rbp]			# | rdx := rbp[-24] = start.tv_nsec
	mov	rdi, QWORD PTR -48[rbp]			# | rdi := rbp[-48] = end.tv_sec
	mov	rsi, QWORD PTR -40[rbp]			# | rsi := rbp[-40] = end.tv_nsec
	mov	rcx, rdx						# | rcx := rdx = start.tv_nsec
	mov	rdx, rax						# | rdx := rax = start.tv_sec
	call	getTimeDiff					# | Вызываем getTimeDiff(rdi=end.tv_sec, rsi=end.tv_nsec, rdx=start.tv_sec, rcx=start.tv_nsec)
										# | Функция вернула значение через rax
	add	r15, rax						# | elapsed = r15 := r15 + rax = elapsed + getTimeDiff(end, start)
	add	r14, 1							# | ++i
.L33:
	cmp	r14, QWORD PTR -56[rbp]			# | Сравниваем i (r14) и sample_size (rbp[-56])
	jl	.L34							# | Если i < sample_size, переходим к телу цикла
	mov	rax, r15						# | Иначе возвращаем из функции значение elapsed (r15) через rax
	
	leave								# | Эпилог функции
	ret									# \
	.size	measureTime, .-measureTime
# ^
# Вместо хранения на стеке используется хранение в регистрах r12, r13, r14, r15 

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
