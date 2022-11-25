	.intel_syntax noprefix
	.text
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
