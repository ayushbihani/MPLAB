assume cs:code,ds:data

data segment
	msg db "Error$"
	file db "text.txt" ;your filename goes here (ex if your filename is abcd.txt then write "abcd.txt"
	buff db 100 dup(?)
data ends

code segment
start:
	mov ax,data
	mov ds,ax
	mov al,00
	lea dx,file  ;file name
	mov ah,3dh  ;to open file
	int 21h
	jc fail	;cf=1 if fail

	;to read contents
	mov bx,ax ;puts file handler in bx
	mov ah,3fh
	mov cx,100d 	;no of char
	lea dx,buff	;destination
	int 21h

	;to close file
	mov ah,3eh
	int 21h
	
	;to display contents
	lea di,buff
	mov cx,100d
next:
	mov dl,[di]
	mov ah,02
	int 21h
	inc di
	loop next
	jmp last

fail:
	lea dx,msg
	mov ah,9
	int 21h
last:
	mov ah,4ch
	int 21h	
code ends
end start
