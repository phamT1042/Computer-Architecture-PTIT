; Viet chuong trinh hop ngu in ra loi chao tieng Anh va tieng Viet
.model small
.stack 100
.data
    chaoTa db 13, 10, 'Xin chao$'
    chaoTay db 'Hello$'
.code
main proc  
    mov ax, @data
    mov ds, ax
    
    lea dx, chaoTay ;tro con tro dx vao xau chaoTay
    mov ah, 9       ;in xau ki tu co dia chi trong dx
    int 21h
    
    lea dx, chaoTa  ;tro con tro dx vao xau chaoTa
    mov ah, 9       ;in xau ki tu co dia chi trong dx
    int 21h
    
    mov ah, 4ch
    int 21h
main endp

end main
