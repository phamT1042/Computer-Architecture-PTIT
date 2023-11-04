.model small
.stack 100
.data
    tb1 db 'Nhap so thu nhat: $'
    tb2 db 13, 10, 'Nhap so thu hai: $'
    tb3 db 13, 10, 'UCLN cua 2 so: $'
    tb4 db 13, 10, 'BCNN cua 2 so: $'
    tb5 db 13, 10, 'Khong ton tai UCLN cua 2 so 0$'  
    x db ?
    y db ?
    UCLN db ?
    BCNN dw ?
.code
main proc
    mov ax, @data
    mov ds, ax
     
    lea dx, tb1          ;in thong bao nhap so thu nhat
    mov ah, 9
    int 21h
    
    call inputNumber     ;nhap so thu nhat luu vao x
    mov x, cl
    
    lea dx, tb2          ;in thong bao nhap so thu 2
    mov ah, 9
    int 21h
    
    call inputNumber     ;nhap so thu 2 luu vao y
    mov y, cl   
    
    mov ah, 0            ;reset ah de luu UCLN vao al
    call timUCLN   
    
    mov ax, 0            ;reset ax de luu BCNN vao ax
    call timBCNN
                 
    mov ah, 4ch
    int 21h  
main endp

inputNumber proc         ;gia tri so duoc nhap luu vao cl
    mov bx, 10
    mov cx, 0           
    
    loopNhap:    
        mov ah, 1        ;ngat 1 nhap 1 ki tu vao al
        int 21h
        cmp al, 13, 10   ;ket thuc nhap neu gap ki tu xuong dong
        je endInput    
        mov dl, al
        mov al, cl       ;nhan so hien tai voi 10
        mul bl
        sub dl, '0'
        add al, dl       ;cong them so vua nhap
        mov cl, al
        jmp loopNhap    
        
    endInput:
    ret
inputNumber endp   

outputNumber proc        ;in gia tri so luu trong ax
    mov cx, 0            ;bien dem so chu so
    mov bx, 10             
    mov dx, 0                                   
    
    loopPush: 
        div bx           ;dx = dxax % bx, ax = dxax / bx
        push dx                   ;day phan du dx vao stack
        inc cl           ;tang so chu so them 1
        cmp ax, 0        ;so sanh phan nguyen ax voi 0
        je inRa          ;phan nguyen = 0 -> ket thuc loop
        mov dx, 0        ;gan lai phan du ve 0 tranh loi khi chia
        jmp loopPush
    
    inRa:        
        pop ax           ;pop pt dau stack vao ax    
        mov dl, al
        add dl, '0'      ;chuyen so -> ki tu so
        mov ah, 2        ;in ki tu trong dl
        int 21h
        loop inRa       
    ret
outputNumber endp   

timUCLN proc    
    mov cx, 0
    mov bx, 0
    mov bl, x            ;bl = x
    mov cl, y            ;cl = y
        
    cmp bl, 0
    je if_x_0
    cmp cl, 0
    je if_y_0
    jmp Euler
    
    if_x_0:
        cmp cl, 0
        je error         ;neu x = y = 0 -> khong co UCLN
        mov al, cl       ;neu x = 0, y != 0 -> UCLN = y = al
        jmp inUCLN       
    if_y_0:
        cmp bl, 0
        je error
        mov al, bl       ;neu y = 0, x != 0 -> UCLN = x = al
        jmp inUCLN 
        
    Euler:   
        cmp bl, cl
        jb giam_y        ;neu x < y
        sub bl, cl       ;giam_x
        jmp check
        
    giam_y:
        sub cl, bl      
    
    check:
        cmp bl, 0
        je if_x_0
        cmp cl, 0
        je if_y_0
        jmp Euler     
        
    inUCLN:    
        mov UCLN, al  
        lea dx, tb3      ;in thong bao in UCLN
        mov ah, 9
        int 21h 
        mov ax, 0
        mov al, UCLN     ;gan UCLN vao al
        call outputNumber             
        jmp endUCLN    
        
    error:
        lea dx, tb5      ;in thong bao loi
        mov ah, 9
        int 21h 
        
    endUCLN: 
    ret
timUCLN endp      

timBCNN proc    
    mov cx, 0
    mov bx, 0
    mov bl, x
    mov cl, y
    
    mov al, x
    mul y                ;ax = al * y = x * y
    cmp al, 0
    je inBCNN            ;neu it nhat 1 trong 2 so bang 0 -> BCNN = 0
    mov bl, UCLN
    mov dx, 0
    div bx               ;ax = dxax / bx
        
    inBCNN:    
        mov BCNN, ax
        lea dx, tb4      ;in tb in BCNN
        mov ah, 9
        int 21h   
        mov ax, BCNN
        call outputNumber            
    ret
timBCNN endp 

end main
