;Viet chuong trinh cho phep nhap 1 so va in ra giai thua so do
.model small
.stack 100
.data
    tb1 db 'Nhap 1 so: $'
    tb2 db 13,10,'Giai thua so vua nhap: $'
.code
main proc
    mov ax, @data
    mov ds, ax
     
    lea dx, tb1          ;in thong bao nhap so
    mov ah, 9
    int 21h
    mov ah, 1            ;nhap 1 ki tu so
    int 21h
    sub al, '0'          ;chuyen ki tu so -> so
    mov cl, al           ;gan so tu al vao cl
    
    lea dx, tb2          ;in thong bao in giai thua
    mov ah, 9
    int 21h
    
    mov ax, 1            ;khoi tao giai thua dau tien bang 1
    mov bx, 1            ;bien dem 
    
    loopGT:
        mul bx           ;dxax = ax * bx
        inc bx           ;bx++
        cmp bx, cx       ;so sanh bx va cx
        jle loopGT       ;neu bx <= cx thi loop tiep
    
    mov cx, 0            ;bien dem so chu so cua giai thua
    mov bx, 10           ;gan bx = 10 de chia nguyen/du
    
    loopPush: 
        div bx           ;dx = dxax % bx, ax = dxax / bx
        push dx          ;day phan du dx vao stack
        inc cx           ;tang so chu so them 1
        cmp ax, 0        ;so sanh phan nguyen ax voi 0
        je inGT          ;phan nguyen = 0 -> ket thuc loop
        mov dx, 0        ;gan lai phan du ve 0 tranh loi khi chia
        jmp loopPush
    
    inGT:        
        pop dx           ;pop pt dau stack vao dx
        add dx, '0'      ;chuyen so -> ki tu so
        mov ah, 2        ;in ki tu trong dl
        int 21h
        loop inGT        ;lap de in het (cx-- den cx = 0)   
        
    mov ah, 4ch
    int 21h
main endp     
        
end main
