.model small
.stack 100
.data   
    tb1 db 'Nhap so nhi phan: $'
    tb2 db 13, 10, 'So thap luc phan tuong ung: $'    
    endl db 13, 10,'$'
    tbLoi db 13, 10, 'Error: So ban vua nhap chua ki tu khac 0 va 1$' 
.code
main proc  
    mov ax, @data
    mov ds, ax
    
    lea dx, tb1        ;in thong bao nhap
    mov ah, 9
    int 21h             
    
    mov ah, 1          ;lenh goi ham ngat 1 nhap 1 ki tu vao al
    mov bl, 0          ;bl luu gia tri thap phan
    mov cx, 8          ;cl luu so lan lap ung voi 8bit nhi phan

LOOP_INPUT:
    int 21h       
    cmp al, '#'        ;neu la '#' thi ket thuc nhap
    je LOOP_OUTPUT
    cmp al, '0'        
    jl error           ;nho hon tuc khong phai 0 hoac 1
    cmp al, '1'        
    jg error           ;lon hon tuc khong phai 0 hoac 1
    sub al, '0'        ;chuyen ki tu ve so
    shl bl, 1          ;dich trai cac bit cua bl
    or bl, al          ;them gia tri bit cuoi vua nhap vao bl
    loop LOOP_INPUT 
    
    jmp LOOP_OUTPUT     
    
error:                    
    lea dx, tbLoi      ;in thong bao loi input  
    mov ah, 9          
    int 21h  
    jmp end            
    
LOOP_OUTPUT:            
    lea dx, tb2        ;in thong bao xuat so he 16    
    mov ah, 9
    int 21h                                           
    
    mov dl, '0'        ;in ky tu 0 dau tien
    mov ah, 2
    int 21h
    
    mov ax, 0          ;reset lai thanh ghi ax
    mov al, bl         
    mov bx, 16         ;khoi tao bl bang 16 de chia du
    mov cx, 0          ;dem so chu so  
    
    loop16:                    
        div bl         ;ah = ax % bl, al = ax / bl          
        push ax                
        inc cx         ;tang bien dem so chu so them 1 
        cmp al, 0      ;neu phan nguyen bang 0 thi ket thuc chia -> in ra        
        je in16
        mov ah, 0      ;gan phan du ah ve 0 tranh sai khi chia
        jmp loop16                
    
    in16:         
        checkHexa:         
            pop ax       ;lay gia tri dinh stack gan vao ax         
            mov dl, ah   ;lay phan du chuyen vao dl                  
            cmp dl, 10   ;neu dl = 10 chuyen den chuyen sang ki tu A             
            je hex_a          
            cmp dl, 11   ;neu dl = 11 chuyen den chuyen sang ki tu B         
            je hex_b         
            cmp dl, 12   ;neu dl = 12 chuyen den chuyen sang ki tu C         
            je hex_c         
            cmp dl, 13   ;neu dl = 13 chuyen den chuyen sang ki tu D         
            je hex_d         
            cmp dl, 14   ;neu dl = 14 chuyen den chuyen sang ki tu E         
            je hex_e         
            cmp dl, 15   ;neu dl = 15 chuyen den chuyen sang ki tu F         
            je hex_f                   
            add dl,'0'   ;neu dl < 10 => chuyen so thanh ki tu so        
            jmp print    ;nhay den ham print ki tu  
                            
        hex_a:               
            mov dl,'A'             
            jmp print              
        hex_b:               
            mov dl,'B'             
            jmp print         
        hex_c:               
            mov dl,'C'
            jmp print         
        hex_d:             
            mov dl,'D'           
            jmp print   
        hex_e:    
            mov dl,'E' 
            jmp print           
        hex_f:               
            mov dl,'F'              
            jmp print  
                
        print:           ;in 1 ky tu ra man hinh          
            mov ah, 2        
            int 21h             
            loop in16
            
    mov dl, 'h'
    int 21h    
end:   
    mov ah, 4ch
    int 21h
main endp
end main
