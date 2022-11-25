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
