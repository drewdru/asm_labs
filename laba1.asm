;лабораторная №1
model small
.stack	100h
.data
argument1   equ 2
len equ	10	;количество элементов в mas
mas	db	1,11,9,8,3,7,8,0,2,6
res   db    10 dup(?)
.code
start:
	mov	ax,@data
	mov	ds,ax
	mov	cx,len	;длину поля mas в cx
	xor si,si
	jcxz	exit	;проверка cx на 0, если 0, то на выход
cycl:
	xor ax,ax
	cmp	mas[si],10	;сравнить очередной элемент mas с 10
	ja  m1	;если >10, то на m1 
	mov al,argument1	;умножение y=ax
	mul mas[si]
	mov res[si],al
	cmp mas[si],5
	jbe nxt	;если <=5, то на nxt
	mov al,argument1
	add res[si],al	;+a
	jmp nxt	
m1:
	mov al,0
	mov res[si],al
nxt:
	inc	si	;перейти к следующему элементу
	loop cycl
exit:
	mov	ax,4c00h
	int	21h	;возврат управления операционной системе
end	start

