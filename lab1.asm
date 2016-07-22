; Standard header:
	#make_COM#
        ORG  100H  
        
Title lab1         

dat segment
	R equ 100h   ;R=100h
	x equ 2h   ;x = 2h
	y equ 5h   ;y = 5h
	result db 0
dat ends
cod segment
	assume cs: cod, ds: @dat
start:
	mov ax,x   ;x -> ax
	imul ax  ;x*x
	mov bx,ax;bx=x*x
	
	mov ax,y   ;y -> ax
	imul ax    ;ax = y*y
	add ax,bx  ;ax=ax+bx
	
	mov bx,R   ;bx=R=100h
	
	cmp ax,bx   ;ax == R
	JG @bad

	@good:
	mov [1478],200h
	jmp Exit
	@bad:
	mov [1478],100h
	Exit:
		cod ends
		int 21h       ;stop prog
		int 20h
	end Exit
end start
