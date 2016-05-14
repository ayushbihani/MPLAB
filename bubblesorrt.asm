assume cs:code,ds:data

data segment
        num db 10h,58h,33h,20h,45h
        n dw $-num

data ends

code segment
start:
        mov ax,data
        mov ds,ax
        mov cx,n    
        dec cx      ;counter variable for outer loop
        mov dx,cx   ;counter variable for inner loop
       
  NEXT:
         mov di,00     ;displacement
         mov dx,cx
   NEXT2:
        mov al,num[di]
        mov ah,num[di+1]
        cmp  al,ah
        jle set          
       
        mov num[di],ah     ;swap
        mov num[di+1],al

   SET:  inc di
        dec dx
        jnz next2         ;inner loop check condition

        loop next       
			;outer loop condition
        lea si,num
        mov cx,n
 display:
         mov al,[si]
         call disp
         inc si   
         loop display     
          mov ah,4ch
        int 21h           
        
  disp proc
        aam
        add ax,3030h
        mov dl,ah
        mov ah,2
        push ax
        int 21h
        pop ax
        mov dl,al
        mov ah,2
        int 21h
        mov dl,0dh
        mov ah,2
        int 21h    
        mov dl,0ah
        mov ah,02
        int 21h   
        ret
        
       

code ends
end start
