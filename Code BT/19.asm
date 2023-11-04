.model small
.stack 100
.data
    str1 db 'Fun with Assembly code$'
    str2 db 'code fun$'   
    tb1 db 'Xau A: $'
    tb2 db 13, 10, 'Xau B: $'
    tb3 db 13, 10, 'Xau B khong phai la xau con cua xau A$'
    tb4 db 13, 10, 'Xau B la xau con cua xau A, vi tri xau B la: $'
    viTri db -1
.code
main proc
    mov ax, @data
    mov ds, ax
 
    lea dx, tb1                     ;in tb xau A
    mov ah, 9
    int 21h
    
    lea dx, str1                    ;in xau A
    int 21h
    
    lea dx, tb2                     ;in tb xau B
    int 21h
    
    lea dx, str2                    ;in xau B
    int 21h
    
    mov ax, 0                       
    mov bx, 0                       
    mov dx, 0
    call xauCon 
    
    cmp viTri, -1     
    je khongThay    
    
    lea dx, tb4                     ;neu tim thay, in tb in vi tri
    mov ah, 9
    int 21h         
    
    mov ax, 0                       
    mov al, viTri    
    call outputNumber     
    jmp end                 

    khongThay:                      ;neu khong thay in tb khong tim duoc
        lea dx, tb3
        mov ah, 9
        int 21h
       
    end:          
    mov ah, 4ch
    int 21h  
main endp      

xauCon proc  
    mov si, 0
    mov di, 0       
    
    for1: 
        mov al, str1[si]                 ;gan ki tu o str1[i] vao al
        cmp str1[si], '$'                ;neu do la cuoi xau thi ket thuc tim xau con
        je endXC
        mov bl, str2[0]                  ;gan ki tu o str2[0] vao bl
        cmp al, bl                       ;neu giong nhau thi chuan bi for2 de check
        je giong
        inc si                           ;khac thi tang si len, lap tiep for1
        jmp for1   
        
        giong: 
            inc si                       ;tang si, di sang ki tu tiep theo trong str1 va str2
            inc di
            mov dx, si                   ;luu tam vi tri si hien tai vao dx
            cmp str2[di], '$'            ;neu str2 da den cuoi xau -> xau con cua A
            je timThay
            
            for2:
                mov al, str1[si]
                mov bl, str2[di]
                cmp al, bl               ;neu khac thi ra khoi for2, ve for1
                jne khac 
                inc si                   ;neu giong thi nhay sang ki tu tiep theo trong str1 va str2
                inc di
                cmp str2[di], '$'        ;neu str2 da den cuoi xau -> xau con cua A
                je timThay      
                cmp str1[si], '$'        ;neu str1 da den cuoi xau -> ket thuc lap for1
                je endXC
                jmp for2                 
                
            timThay:
                mov viTri, dl            
                jmp endXC
            
            khac:
                mov si, dx               ;reset si ve vi tri da duoc luu trong dx
                mov di, 0                ;reset di
                jmp for1                 ;lap lai for1
                    
    endXC:
    ret
xauCon endp  

outputNumber proc
    mov cx, 0            ;bien dem so chu so
    mov bx, 10                                   
    
    loopPush: 
        div bl           ;ah = ax % bl, al = ax / bl
        push ax          
        inc cl           ;tang so chu so them 1
        cmp al, 0        ;so sanh phan nguyen al voi 0
        je inRa          ;phan nguyen = 0 -> ket thuc loop
        mov ah, 0        ;gan lai phan du ve 0 tranh loi khi chia
        jmp loopPush
    
    inRa:        
        pop dx  
        mov dl, dh
        add dl, '0'      ;chuyen so -> ki tu so
        mov ah, 2        ;in ki tu trong dl
        int 21h
        loop inRa       
    ret
outputNumber endp

