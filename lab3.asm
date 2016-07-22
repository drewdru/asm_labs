#make_COM#
ORG  100H  

dat segment
	num_str db 0
	num_column db 0
dat ends
cod segment
assume cs: cod, ds: dat

start:  
mov ax, dat
mov ds,ax

mov cx,50	;количество смещений в лево
mov num_str,0	;номер строки
mov num_column,50	;номер столбца

cycle1:
call clear
call WRITE_column
	mov num_str,0  
	dec num_column 	
mov ax,4C00h
loop cycle1
int 21h    

;вывод 3х колонок символов
WRITE_column Proc Near:
push cx
mov cx,10
c2:
	call ST
       	call WRITE  
       	inc num_str
loop c2 	
pop cx
ret  
WRITE_column Endp

;установка курсора
ST Proc Near:
	MOV  AH,02          ;Установить положение курсора
        MOV  BH,00          ;Страница 0
     	MOV  DH,num_str     ;Строка
      	MOV  DL,num_column     ;Столбец
       	INT  10H            ;Вызвать BIOS
ret  
ST Endp


;вывод 3-х симолов	
WRITE Proc Near:
push cx
push ax
mov cx,3
	CYCLE:
	mov DL, 50;<код выводимого символа>
	mov AH, 2
	int 21h
	loop CYCLE
pop ax
pop cx
ret  
WRITE Endp

;очистка экрана
CLEAR Proc Near:
push cx
push ax
	MOV  AX,0600H  ;AH 06 (прокрутка)
	               ;AL 00 (весь экран)
	MOV  BH,07     ;Нормальный атрибут (черно/белый)
	MOV  CX,0000   ;Верхняя левая позиция
	MOV  DX,184FH  ;Нижняя правая позиция
	INT  10H       ;Передача управления в BIOS
pop ax
pop cx
ret  
CLEAR Endp

cod ends
end start