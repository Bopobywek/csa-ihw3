	.intel_syntax noprefix
	.text
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

