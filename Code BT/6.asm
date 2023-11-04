; Viet chuong trinh cho phep nhap 1 chuoi ki tu ket thuc 
;boi "#" va in ra chuoi do theo thu tu nguoc lai
.model small
.stack 100
.data
    tb1 db 'Nhap 1 chuoi ky tu: $'
    tb2 db 13,10,'Xau ky tu vua nhap in nguoc: $'
    xau db 255, 0, 255 dup('$')
    length db 0          ;luu chieu dai chuoi
.code
main proc
    mov ax, @data
    mov ds, ax
     
    lea dx, tb1          ;in thong bao nhap chuoi
    mov ah, 9
    int 21h
    
    lea dx, xau          ;nhap chuoi
    mov ah, 10
    int 21h
    
    lea dx, tb2          ;in thong bao in chuoi nguoc
    mov ah, 9
    int 21h
    call inNguoc         ;goi ham con inNguoc
                 
    mov ah, 4ch
    int 21h  
main endp

inNguoc proc 
    lea si, xau + 2      ;tro con tro si den vi tri xau + 2
    lapDenCuoi:
        cmp [si], '#'    ;kiem tra da tro den cuoi xau chua
        je break         ;break neu roi
        inc si           ;i++
        inc length       ;length++
        jmp lapDenCuoi
    break:
        dec si           ;giam con tro s[i] xuong 1 de tro den ki tu cuoi cung
        inDao:
            mov dl, [si] ;gan gia tri s[i] vao dl
            mov ah, 2    ;in ki tu trong dl
            int 21h
            dec si       ;giam con tro s[i] di 1
            dec length   ;giam chieu dai chuoi di 1
            cmp length, 0;neu chieu dai chuoi chua bang 0 thi lap tiep
            jne inDao
    ret
inNguoc endp

end main
