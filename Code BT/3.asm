; Viet chuong trinh nhap 1 chuoi ki tu va in chuoi ra
.model small
.stack 100
.data
    tb1 db 'Nhap 1 chuoi ky tu: $' 
    tb2 db 13, 10, 'Chuoi ky tu vua nhap: $'
    chuoi db 100 dup('$')
.code
main proc  
    mov ax, @data
    mov ds, ax
    
    lea dx, tb1     ;in thong bao nhap chuoi
    mov ah, 9
    int 21h
    
    lea dx, chuoi   ;nhap chuoi
    mov ah, 10
    int 21h
    
    lea dx, tb2     ;in thong bao in chuoi
    mov ah, 9
    int 21h
    
    lea dx, chuoi+2 ;luu dia chi chuoi+2 vao dx
    mov ah, 9       ;in chuoi co dia chi luu trong dx
    int 21h
    
    mov ah, 4ch
    int 21h
main endp

end main
