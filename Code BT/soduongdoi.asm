.model small
.stack 100h
.data   
    str db 'PHAM VAN TIEN : 16-10-2003$'   
    sum db 0                              
    str2 db 13, 10, 'SO DUONG DOI la $'
.code   
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, str
    mov ah, 9
    int 21h       
    
    lea si, str  
loop: 
    cmp [si], '$'
    je cal
    cmp [si], '1'
    jb next
    cmp [si], '9'
    ja next
    mov al, [si]
    sub al, '0'
    add sum, al
    next:
        inc si
        jmp loop
        
cal:   
    mov ax, 0    
    mov al, sum
    mov bx, 10
    
    div bl
    add al, ah  
    mov bl, al
    
    lea dx, str2 
    mov ah, 9
    int 21h
    
    mov dl, bl         
    add dl, '0'
    mov ah, 2
    int 21h
    
    mov ah, 4ch
    int 21h
main endp
end main
 