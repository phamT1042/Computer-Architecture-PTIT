;Viet chuong trinh dem chieu dai cua 1 chuoi ki tu cho truoc
.model small
.stack 100
.data
    str db 'Chuoi ki tu nay da duoc cho truoc$'
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea si, str 
    mov ax, 0
count_ki_tu:     
    cmp [si], '$'
    je chuyen
    inc ax
    inc si
    jmp count_ki_tu  
    
chuyen:   
    mov cx, 0        ;khoi tao bien dem
    mov bx, 10       ;khoi tao so chia
    
lapDem:              ;lap de day cac so vao stack
    div bl
    push ax
    inc cl
    cmp al, 0
    je inLength
    mov ah, 0
    jmp lapDem 
    
inLength:            ;lap de pop cac so trong stack ra   
    pop ax           ;lay tu stack ra cho vao ax 
    mov dl, ah       ;lay phan tu ah
    add dl, '0'      ;chuyen so -> ki tu so       
    mov ah, 2
    int 21h
    loop inLength    ;loop den khi cx = 0 (cx--)
                     
    mov ah, 4ch
    int 21h  
main endp

end main
