;Viet chuong trinh chuyen 1 so tu he 10 sang he nhi phan
.model small
.stack 100
.data
.code
main proc
    mov ax, @data
    mov ds, ax
     
    mov ax, 471          ;chuyen 471 sang he nhi phan              
    
    mov bx, 2            ;chia nguyen/du chuyen sang nhi phan    
    mov cx, 0            ;luu so bit nhi phan
    loopNP:        
        div bl           ;lay so hien tai (trong ax) chia cho 2
        push ax          ;day gia tri ax vao ngan xep (gom phan du ah va phan nguyen al)
        inc cx           ;tang so bit them 1
        cmp al, 0        ;neu phan nguyen bang 0 thi ket thuc chia -> in ra
        je inNP
        mov ah, 0        ;gan phan du ah ve 0 tranh sai khi chia (chi chia phan nguyen al)
        jmp loopNP
        
    inNP:  
        pop ax           ;lay gia tri dinh stack gan vao ax 
        mov dl, ah       ;lay phan du chuyen vao dl
        add dl, '0'      ;chuyen so sang ki tu
        mov ah, 2        ;in ki tu
        int 21h
        loop inNP
        
    mov ah, 4ch
    int 21h
main endp     
        
end main
