	.intel_syntax noprefix
	.text
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
