;Найти минимальное значение из максимальных значений
; строк матрицы А(I,J). Нахождение максимального
;значения строки матрицы оформить в виде подпрограммы.
;I, J=1,2,...,5.
.model small
dat segment	
	mas db 1,7,2,5,4
		db 6,2,4,1,3
		db 2,3,1,4,5
		db 2,9,6,3,1
		db 3,5,8,7,2
	;Размер массив nxm
	n db 5
	m db 5
	min_of_max db ? ;Результат
dat ends
cod segment
	assume cs: cod, ds: dat
start:
    mov ax, dat
    mov ds,ax
    lea si, mas
    mov cl,0
    call str_max
    mov [min_of_max], dl
cycl1:
    call str_max
    cmp dl, [min_of_max]
    jae label2
    mov min_of_max, dl
label2:
    inc cl
    cmp cl, n
    jl cycl1
    
mov ax,4C00h
int 21h
	
;Процедура dl = str_max(cx)
;Входной параметр cx - номер строки
;Выходной параметр dl - максимальный элемент строки cx
str_max Proc Near
    push cx
    mov al, [m]      ;количество элементов в строке
    mul cl          ;Умножаем на количество строк
    mov bp, ax      ;В базовый регистр-указатель помещаем индекс первого элемента нужной строки
    mov cx, 0
    mov dl,[si][bp] ;Предполагаем, что нулевой элемент строки cx - максимальный
cycl3:
    cmp [si][bp], dl
    jle label1      ;Если элемент массива меньше dl - прыгаем
    mov dl,[si][bp] ;Обновляем текущий максимальный элемент 
label1:
    inc bp          ;Переходим к следующему элементу строки cx
    inc cx
    cmp cl, [m]     ;Сравниваем с размером массива
    jl cycl3        
    pop cx
	ret             ;Возврат к вызывающей процедуре
str_max Endp        ;Конец процедуры
cod ends
end start
