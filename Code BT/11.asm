;Viet chuong trinh tim GTLN va GTNN trong 1 mang cac so       
;Dang bi loi
.model small
.stack 100
.data
    arr db 83, 65, 92, 105, 34, 254
    tb1 db 'Gia tri lon nhat trong mang: $'
    tb2 db 13, 10, 'Gia tri nho nhat trong mang: $' 
    chia db 10
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, 7   
    lea si, arr          
    mov ax, 0
    mov bl, [si]
    mov dl, [si]
    inc si
     
loopArr:
    mov al, [si]
    cmp al, bl
    jg updateMax
    cmp al, dl
    jl updateMin
    inc si       
    jmp next
updateMax:
    mov bl, al
    jmp next
updateMin:
    mov dl, al
next: 
    loop loopArr 
    
    mov al, bl           ;chuyen gia tri max vao al
    mov bl, dl           ;chuyen gia tri min vao bl
    mov cx, 0            ;bien dem so chu so cua max  
    
    lea dx, tb1
    mov ah, 9
    int 21h              
    mov ax, 0     
    mov dx, 0            ;reset dx
    
    loopPushMax: 
        div chia         ;ah = ax % chia, al = ax / chia
        push ax          ;day ax vao stack (phan du ah va phan nguyen al)
        inc cl           ;tang so chu so them 1
        cmp al, 0        ;so sanh phan nguyen al voi 0
        je inMax         ;phan nguyen = 0 -> ket thuc loop
        mov ah, 0        ;gan lai phan du ah ve 0 tranh loi khi chia
        jmp loopPushMax
    
    inMax:        
        pop ax           ;pop pt dau stack vao ax   
        mov dl, ah       ;gan phan du ah vao dl
        add dl, '0'      ;chuyen so -> ki tu so
        mov ah, 2        ;in ki tu trong dl
        int 21h  
        loop inMax       ;lap de in het (cx-- den cx = 0)   
        
    lea dx, tb2
    mov ah, 9
    int 21h
    
    mov ax, 0
    mov al, bl           ;chuyen gia tri min vao ax
    mov cx, 0            ;bien dem so chu so cua min    
    mov dx, 0            ;reset dx
    
    loopPushMin: 
        div chia         ;ah = ax % chia, al = ax / chia
        push ax          ;day ax vao stack (phan du ah va phan nguyen al)
        inc cl           ;tang so chu so them 1
        cmp al, 0        ;so sanh phan nguyen al voi 0
        je inMin         ;phan nguyen = 0 -> ket thuc loop
        mov ah, 0        ;gan lai phan du ah ve 0 tranh loi khi chia
        jmp loopPushMin
    
    inMin:        
        pop ax           ;pop pt dau stack vao ax   
        mov dl, ah       ;gan phan du ah vao dl
        add dl, '0'      ;chuyen so -> ki tu so
        mov ah, 2        ;in ki tu trong dl
        int 21h  
        loop inMin       ;lap de in het (cx-- den cx = 0)    
                   
    mov ah, 4ch
    int 21h  
main endp


end main
