; Viet chuong trinh cho phep nhap 1 ki tu va in ki tu do ra
.model small
.stack 100
.data
    tb1 db 'Nhap 1 ky tu: $'
    tb2 db 13, 10, 'Ky tu da nhap: $'
    kq db ?
.code
main proc
    mov ax, @data
    mov ds, ax
    
    lea dx, tb1 ;gan dia chi lech cua tb1 vao dx
    mov ah, 9   ;ngat loai 9 in xau
    int 21h    
    
    mov ah, 1   ;ngat loai 1 doc 1 ki tu tu ban phim
    int 21h
    mov kq, al  ;gan ki tu vua nhap duoc luu o al vao bien kq
    
    lea dx, tb2 ;gan dia chi lech cua tb2 vao dx
    mov ah, 9   ;ngat loai 9 in xau
    int 21h                
    
    mov dl, kq  ;gan bien kq vao dl
    mov ah, 2   ;ngat loai 2 in ki tu la gia tri dl
    int 21h
         
               
    mov ah, 4ch
    int 21h  

main endp

end main
