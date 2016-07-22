model small
.stack	100h
.data
len equ	5	;количество элементов в mas
masA	db	10,11,2,8,3
masB	db	2,3,7,10h,12h
maxA	db	?
minA 	db	?	
result db	0
.code
;
;
min_mas proc near
;процедура нахождения минимального элемента 
;в массиве
;bx-адрес массива
;cx-количество элементов
;выход al
	push si
	xor si,si
	mov al,0ffh
	jcxz getout	;не ноль ли в сх?
go:
	cmp al,bx[si]	;сравниваем с элементом массива
	jbe nxt	;если больше или равно, то следующий
	mov al,bx[si]
nxt:
	inc si
	loop go
getout:
	pop si
ret
min_mas endp
;
;
max_mas proc near
;процедура нахождения максимального элемента 
;в массиве
;bx-адрес массива
;cx-количество элементов
;выход al
	push si
	xor si,si
	mov al,0
	jcxz getout1	;не ноль ли в сх?
go1:
	cmp al,bx[si]	;сравниваем с элементом массива
	jae nxt1	;если больше или равно, то следующий
	mov al,bx[si]
nxt1:
	inc si
	loop go1
getout1:
	pop si
ret
max_mas endp
;
;
order proc near
;ax-операнд1
;bx-операнд2
;выход: ax- максимальный,bx-минимальный
	push si
	cmp ax,bx
	jae getout2
	mov si,ax
	mov ax,bx
	mov bx,si
getout2:
	pop si
ret
order endp
;
;
start proc
	mov ax,@data
	mov ds,ax
	lea bx,masA
	mov cx,len
	call min_mas
	mov minA,al
	mov cx,len
	call max_mas
	mov maxA,al
	mov ax,5
	mov bx,6
	call order
exit:
	mov	ax,4c00h
	int	21h	;возврат управления операционной системе

start endp
end	start