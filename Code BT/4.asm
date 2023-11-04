.model small
.stack 100
.data
    tb1 db 'Nhap 1 ky tu thuong: $'
    tb2 db 13,10,'Ky tu in hoa tuong ung: $'
    kq db ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, tb1      ;in thong bao nhap ki tu thuong
    mov ah, 9
    int 21h
    
    mov ah, 1        ;ngat 1 nhap ki tu thuong
    int 21h
    mov kq, al       ;luu ki tu thuong vua nhap vao kq
    
    lea dx, tb2      ;in thong bao in ki tu in hoa tuong ung
    mov ah, 9
    int 21h
    
    mov dl, kq       
    sub dl, 32       ;chuyen sang ki tu hoa
    
    mov ah, 2        ;in ki tu luu trong dl
    int 21h
                 
    mov ah, 4ch
    int 21h  
main endp
end main
