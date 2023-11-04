;Viet chuong trinh chuyen 1 so tu he 10 sang he 16
.model small
.stack 100
.data
.code
main proc
    mov ax, @data
    mov ds, ax
     
    mov ax, 4092         ;chuyen 4092 sang he 16              
    
    mov bx, 16           ;chia nguyen/du chuyen sang he 16    
    mov cx, 0            ;luu so chu so he 16
    loop_hexa:        
        div bl           ;lay so hien tai (trong ax) chia cho 16
        push ax          ;day gia tri ax vao ngan xep (gom phan du ah va phan nguyen al)
        inc cx           ;tang so chu so them 1
        cmp al, 0        ;neu phan nguyen bang 0 thi ket thuc chia -> in ra
        je in_hexa
        mov ah, 0        ;gan phan du ah ve 0 tranh sai khi chia (chi chia phan nguyen al)
        jmp loop_hexa
        
    in_hexa:  
        pop ax           ;lay gia tri dinh stack gan vao ax 
        mov dl, ah       ;lay phan du ah gan vao dl 
        cmp dl, 10       ;neu dl = 10 chuyen den chuyen sang ki tu A             
        je hex_a          
        cmp dl, 11       ;neu dl = 11 chuyen den chuyen sang ki tu B         
        je hex_b         
        cmp dl, 12       ;neu dl = 12 chuyen den chuyen sang ki tu C         
        je hex_c         
        cmp dl, 13       ;neu dl = 13 chuyen den chuyen sang ki tu D         
        je hex_d         
        cmp dl, 14       ;neu dl = 14 chuyen den chuyen sang ki tu E         
        je hex_e         
        cmp dl, 15       ;neu dl = 15 chuyen den chuyen sang ki tu F         
        je hex_f                   
        add dl,'0'       ;neu dl < 10 => chuyen so thanh ki tu so        
        jmp print        ;nhay den ham print ki tu                  
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
            loop in_hexa 
        
    mov ah, 4ch
    int 21h
main endp     
        
end main
