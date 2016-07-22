masm
model small
.stack 100h
delay macro time
	local	ext,iter
	push	cx
	mov	cx,time
ext:
	push	cx
	mov	cx,5000
iter:
	loop	iter
	pop	cx
	loop	ext
	pop	cx
endm
.data
y equ 25
x equ 79
.code
main:
	mov ax,@data
	mov ds,ax
	xor ax,ax
	mov ah,5 ;Задание активной страницы.
	mov al,0 
	int 10h  
	mov cx,x
	mov dx,0
cycl1:
	push cx
	mov cx,y
cycl2:
	mov ah,2
	int 10h
	push cx
	mov cx,1
	mov al,4 ;Задание ASCII-кода символа.
	mov ah,10 ;Функция вывода символа.
	int 10h
	pop cx 
	inc dh
	loop cycl2
	delay 10000
;
	mov dh,0
	mov cx,y
cycl3:
	mov ah,2
	int 10h
	push cx
	mov cx,1
	mov al,0 ;Задание ASCII-кода символа.
	mov ah,10 ;Функция вывода символа.
	int 10h
	pop cx 
	inc dh
	loop cycl3
;
	pop cx
	mov dh,0
	inc dl
	loop cycl1
exit:
	mov	ax,4c00h
	int	21h	;возврат управления операционной системе
end main


