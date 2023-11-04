; Viet chuong trinh cho phep nhap 1 chuoi ki tu, 
;in ra chuoi do theo dang viet hoa va viet thuong
.model small
.stack 100
.data
    tb1 db 'Nhap 1 chuoi ky tu: $'
    tb2 db 13,10,'Xau ky tu vua nhap dang in hoa: $'
    tb3 db 13,10,'Xau ky tu vua nhap dang in thuong: $'
    xau db 100 dup('$')
.code              
main proc
    mov ax, @data
    mov ds, ax
     
    lea dx, tb1      ;in thong bao nhap chuoi
    mov ah, 9
    int 21h
    
    lea dx, xau      ;nhap chuoi
    mov ah, 10
    int 21h
    
    lea dx, tb2      ;in thong bao in chuoi hoa
    mov ah, 9
    int 21h
    call inHoa       ;goi chuong trinh con inHoa
    
    lea dx, tb3      ;in thong bao in chuoi thuong
    mov ah, 9
    int 21h
    call inThuong    ;goi chuong trinh con inThuong
                 
    mov ah, 4ch
    int 21h  
main endp

inHoa proc
    lea si, xau + 2  ;tro con tro s[i] den vi tri xau + 2
    lapHoa:
        mov dl, [si] ;gan gia tri s[i] vao dl
        cmp dl, 'a'  ;kiem tra dl < 'a'
        jl inH       ;in ra vi khong phai ki tu thuong
        cmp dl, 'z'  ;kiem tra dl > 'z'
        jg inH       ;in ra vi khong phai ki tu thuong
        sub dl, 32   ;dl la 1 ki tu thuong, tru di 32 => hoa
    inH:
        mov ah, 2    ;in gia tri trong dl
        int 21h
        inc si       ;i++
        cmp [si], '$';kiem tra da tro den cuoi chuoi chua
        jne lapHoa   ;neu chua thi lap tiep
    ret
inHoa endp

inThuong proc
    lea si, xau + 2  
    lapThuong:
        mov dl, [si]
        cmp dl, 'A'
        jl inT
        cmp dl, 'Z'
        jg inT
        add dl, 32
    inT:
        mov ah, 2
        int 21h
        inc si
        cmp [si], '$'
        jne lapThuong
    ret
inThuong endp

end main
