.MODEL SMALL
.STACK 100H

.DATA                                                                    
    LOGO1 DB '----- -  ----   -----  --   ----   -----  --   ----$'
    LOGO2 DB '  |   | |         |   |  | |         |   |  | |$'
    LOGO3 DB '  |   | |         |   |--| |         |   |  | |----$'
    LOGO4 DB '  |   | |         |   |  | |         |   |  | |$'
    LOGO5 DB '  |   |  ----     |   |  |  ----     |    --   ----$'
 
    TEAMNAME DB  'Game duoc lam boi nhom 14 - lop 02$' 
    STARTGAME DB 'Bam nut bat ky de bat dau tro choi...$'
    ENDGAME DB 'Nhap y de choi lai, nhap bat ki de ket thuc tro choi: $'

    C1 DB '   |   |   $'            ;ve bang so
    C2 DB ' | $'
    R1 DB '-----------$'
    O1 DB '1' 
    O2 DB '2'
    O3 DB '3'
    O4 DB '4'
    O5 DB '5'           
    O6 DB '6'
    O7 DB '7'
    O8 DB '8'
    O9 DB '9'
    
    PLAYER DB 'X'                   ;khoi tao player dau tien dien X
    MOVES DB 0                      ;so buoc di la 0
    DONE DB 0                       ;check khi co nguoi win
    DW DB 0                         ;check khi hoa nhau

    INPX DB 'Player X nhap o muon chon: $' 
    INPO DB 'Player O nhap o muon chon: $'
    ERROR DB 'O nay da duoc chon. An nut bat ki de nhap lai$' 

    WINX DB 'Player X thang!$'
    WINO DB 'Player O thang!$'
    DRAW DB 'Hai nguoi choi hoa nhau!$'

    ;dung de xoa dong hien thong bao 'o nay da duoc chon'
    EMP DB '                                                                   $'    

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                            
    
    CALL TITLESCREEN  
    
TRYAGAIN:
    CALL INIT
    
LOOPINPUT:
    CMP DW, 1
    JE DRAW_GAME
    CMP DONE, 1
    JE WIN_GAME
    CALL DRAWBOARD
    CALL INPUT
    CALL CHECK_GAME
    CALL CHANGEPLAYER
    JMP LOOPINPUT
   
    DRAW_GAME:  
        CALL DRAWBOARD
        CALL PRINT_DRAW
        JMP EXIT
    
    WIN_GAME:
        CALL DRAWBOARD 
        CALL PRINT_WIN    
    
    EXIT:
        MOV AH, 2
        MOV DH, 18
        MOV DL, 20
        INT 10H
           
        LEA DX, ENDGAME
        MOV AH, 9
        INT 21H
        
        MOV AH, 1
        INT 21H
        
        CMP AL, 'y'
        JE TRYAGAIN
        
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP 

INIT PROC
    MOV O1, '1'
    MOV O2, '2'
    MOV O3, '3'
    MOV O4, '4'
    MOV O5, '5'           
    MOV O6, '6'
    MOV O7, '7'
    MOV O8, '8'
    MOV O9, '9'
    
    MOV PLAYER, 'X'                   ;khoi tao player dau tien dien X
    MOV MOVES, 0                      ;so buoc di la 0
    MOV DONE, 0                       ;check khi co nguoi win
    MOV DW, 0 
    RET
INIT ENDP

TITLESCREEN PROC  
;--------- DISPLAY THE TITLE SCREEN ---------    
    ;LOGO GAME START -----------------
    MOV AH, 2             ;goi ngat 10h voi ham 2, thuc hien viec dich
    MOV DH, 6             ;chuyen con tro den dong 6 (DL)                         
    MOV DL, 14            ;cot 14 (DH) cua man hinh in ra
    INT 10H 
            
    LEA DX, LOGO1
    MOV AH, 9
    INT 21H

    MOV AH, 2
    MOV DH, 7
    MOV DL, 14
    INT 10H 
        
    LEA DX, LOGO2
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DH, 8
    MOV DL, 14
    INT 10H 
           
    LEA DX, LOGO3
    MOV AH, 9
    INT 21H
                
    MOV AH, 2
    MOV DH, 9
    MOV DL, 14
    INT 10H  
              
    LEA DX, LOGO4
    MOV AH, 9
    INT 21H

    MOV AH, 2
    MOV DH, 10
    MOV DL, 14
    INT 10H 
        
    LEA DX, LOGO5
    MOV AH, 9
    INT 21H         
    ;LOGO GAME END -----------------
        
    MOV AH, 2
    MOV DH, 12
    MOV DL, 22
    INT 10H 
            
    LEA DX, TEAMNAME        
    MOV AH, 9
    INT 21H  
    
    MOV AH, 2
    MOV DH, 13
    MOV DL, 21
    INT 10H  
         
    LEA DX, STARTGAME      
    MOV AH, 9
    INT 21H   
    
    MOV AH, 7             ;doc 1 ki tu tu ban phim nhung khong hien ra khi nhap
    INT 21H
      
    RET      
TITLESCREEN ENDP  

CLEARSCREEN PROC
    MOV AX, 0600H         ;goi ngat 10h voi ax = 0600h de xoa man hinh
    MOV BH, 07H           ;color cho nen va ki tu tren nen, o day nen black (0) va ki tu light gray (7) 
    MOV CX, 0000H         ;xoa tu toa do (0 (CL-left most column), 0 (CH-top row)>
    MOV DX, 184FH         ;den toa do (79 (DL-right most column), 24 (DH-bottom row)) (man hinh co 80 cot va 25 dong)
    INT 10H   
    RET
CLEARSCREEN ENDP                     
                   
CHANGEPLAYER PROC    
    CMP PLAYER, 'X'
    JE PLAYER2
    MOV PLAYER, 'X'
    JMP ENDCHANGE
              
    PLAYER2:
        MOV PLAYER, 'O'
                  
    ENDCHANGE:   
    RET
CHANGEPLAYER ENDP   

DRAWBOARD PROC
    CALL CLEARSCREEN                                          
                                           
    MOV BH, 0              
    MOV AH, 2 
    MOV DH, 6
    MOV DL, 30
    INT 10H         
        
    LEA DX, C1
    MOV AH, 9
    INT 21H 
    
    MOV AH, 2
    MOV DH, 7
    MOV DL, 31
    INT 10H

; --------------------------------    
    ; CELL 1 
    MOV DL, O1
    MOV AH, 2
    INT 21H 
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    ; CELL 2
    MOV DL, O2
    MOV AH, 2
    INT 21H
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    ; CELL 3
    MOV DL, O3
    MOV AH, 2
    INT 21H
    
; ---------------------------------  
    MOV AH, 2
    MOV DH, 8 
    MOV DL, 30
    INT 10H  
    
    LEA DX, C1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DH, 9
    MOV DL, 30
    INT 10H
    
    LEA DX, R1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DH, 10
    MOV DL, 30 
    INT 10H
    
    LEA DX, C1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DH, 11
    MOV DL, 31
    INT 10H
    
; --------------------------------    
    ; CELL 4 
    MOV DL, O4
    MOV AH, 2
    INT 21H 
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    ; CELL 5
    MOV DL, O5
    MOV AH, 2
    INT 21H
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    ; CELL 6
    MOV DL, O6
    MOV AH, 2
    INT 21H 
; ---------------------------------     
    MOV AH, 2
    MOV DH, 12
    MOV DL, 30 
    INT 10H
        
    LEA DX, C1
    MOV AH, 9
    INT 21H 
 
    MOV AH, 2
    MOV DH, 13
    MOV DL, 30 
    INT 10H 
     
    LEA DX, R1
    MOV AH, 9
    INT 21H 
    
    MOV AH, 2
    MOV DH, 14
    MOV DL, 30 
    INT 10H
    
    LEA DX, C1
    MOV AH, 9
    INT 21H 
    
    MOV AH, 2
    MOV DH, 15
    MOV DL, 31
    INT 10H        
; --------------------------------    
    ; CELL 7 
    MOV DL, O7
    MOV AH, 2
    INT 21H 
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    ; CELL 8
    MOV DL, O8
    MOV AH, 2
    INT 21H
    
    LEA DX, C2
    MOV AH, 9
    INT 21H
    
    ; CELL 9
    MOV DL, O9
    MOV AH, 2
    INT 21H
    
; ---------------------------------     
    MOV AH, 2
    MOV DH, 16
    MOV DL, 30 
    INT 10H 
    
    LEA DX, C1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DH, 17
    MOV DL, 20 
    INT 10H
   
    RET
DRAWBOARD ENDP

INPUT PROC
    NHAP:                     ;nhan NHAP phuc vu cho viec nhap lai neu taken
        CMP PLAYER, 'X'
        JNE PL_O 
        
        LEA DX, INPX
        MOV AH, 9
        INT 21H
        JMP CONTINUE
    
    PL_O:    
        LEA DX, INPO
        MOV AH, 9
        INT 21H 
    
    CONTINUE:  
        MOV AH, 1             ;ngat 21h cua ham 01: nhan 1 ki tu tu ban phim
        INT 21H               ;luu vao AL
         
        MOV BL, AL            ;luu tam ki tu vua nhap vao BL
        SUB BL, '0'
        
        MOV CL, PLAYER        ;luu tam ki tu cua player hien tai vao CL
        
        ; CHECKING IF INPUT IS BETWEEN 1-9
        CMP BL, 1
        JE  O1U 
        
        CMP BL, 2
        JE  O2U
        
        CMP BL, 3
        JE  O3U
        
        CMP BL, 4
        JE  O4U
        
        CMP BL, 5
        JE  O5U
        
        CMP BL, 6
        JE  O6U
        
        CMP BL, 7
        JE  O7U
        
        CMP BL, 8
        JE  O8U
        
        CMP BL, 9
        JE  O9U  
    ;---------------------------------
    
    ; SETTING BOARD POSITION AS INPUT MARK
    O1U:
        CMP O1, 'X'  
        JE TAKEN
        CMP O1, 'O'
        JE TAKEN 
            
        MOV O1, CL 
        INC MOVES
        JMP ENDINPUT 
    O2U:
        CMP O2, 'X'  
        JE TAKEN
        CMP O2, 'O'
        JE TAKEN 
            
        MOV O2, CL  
        INC MOVES
        JMP ENDINPUT    
    O3U:
        CMP O3, 'X'  
        JE TAKEN
        CMP O3, 'O'
        JE TAKEN 
            
        MOV O3, CL  
        INC MOVES
        JMP ENDINPUT         
    O4U:
        CMP O4, 'X'  
        JE TAKEN
        CMP O4, 'O'
        JE TAKEN 
            
        MOV O4, CL  
        INC MOVES
        JMP ENDINPUT
    O5U:
        CMP O5, 'X'  
        JE TAKEN
        CMP O5, 'O'
        JE TAKEN 
            
        MOV O5, CL  
        INC MOVES
        JMP ENDINPUT    
    O6U:
        CMP O6, 'X'  
        JE TAKEN
        CMP O6, 'O'
        JE TAKEN 
            
        MOV O6, CL  
        INC MOVES
        JMP ENDINPUT
    O7U:
        CMP O7, 'X'  
        JE TAKEN
        CMP O7, 'O'
        JE TAKEN 
            
        MOV O7, CL  
        INC MOVES
        JMP ENDINPUT
    O8U:
        CMP O8, 'X'  
        JE TAKEN
        CMP O8, 'O'
        JE TAKEN 
            
        MOV O8, CL  
        INC MOVES
        JMP ENDINPUT
    O9U:
        CMP O9, 'X'  
        JE TAKEN
        CMP O9, 'O'
        JE TAKEN 
            
        MOV O9, CL  
        INC MOVES
        JMP ENDINPUT   
    
    TAKEN:
        MOV AH, 2
        MOV DH, 17
        MOV DL, 20 
        INT 10H   
            
        LEA DX, ERROR     ;in ra thong bao o nay da bi nhap, yeu cau nhap lai
        MOV AH, 9
        INT 21H  
        
        MOV AH, 7         ;input nhap khong in ra
        INT 21H 
         
        MOV AH, 2
        MOV DH, 17
        MOV DL, 20 
        INT 10H
            
        LEA DX, EMP       ;xoa hang in ra thong bao loi bang cach 
        MOV AH, 9         ;ghi de len no 1 xau trong
        INT 21H 
        
        MOV AH, 2
        MOV DH, 17
        MOV DL, 20 
        INT 10H
        
        JMP NHAP
    ENDINPUT:
    RET              
INPUT ENDP 

CHECK_GAME PROC
    CHECK1:  ; CHECKING 1, 2, 3 
        MOV AL, O1
        MOV BL, O2 
        MOV CL, O3
                
        CMP AL, BL
        JNE CHECK2
                
        CMP BL, CL
        JNE CHECK2
                
        MOV DONE, 1
        JMP ENDCHECK
                
    CHECK2:  ; CHECKING 4, 5, 6 
        MOV AL, O4
        MOV BL, O5 
        MOV CL, O6
                
        CMP AL, BL
        JNE CHECK3
                
        CMP BL, CL
        JNE CHECK3
                
        MOV DONE, 1
        JMP ENDCHECK
                    
    CHECK3:  ; CHECKING 7, 8, 9
        MOV AL, O7
        MOV BL, O8 
        MOV CL, O9
                
        CMP AL, BL
        JNE CHECK4
                
        CMP BL, CL
        JNE CHECK4 
                
        MOV DONE, 1
        JMP ENDCHECK
                     
    CHECK4:   ; CHECKING 1, 4, 7
        MOV AL, O1
        MOV BL, O4 
        MOV CL, O7
                
        CMP AL, BL
        JNE CHECK5
                
        CMP BL, CL
        JNE CHECK5
            
        MOV DONE, 1
        JMP ENDCHECK
    
    CHECK5:   ; CHECKING 2, 5, 8
        MOV AL, O2
        MOV BL, O5 
        MOV CL, O8
                
        CMP AL, BL
        JNZ CHECK6
                
        CMP BL, CL
        JNZ CHECK6
            
        MOV DONE, 1
        JMP ENDCHECK
            
    CHECK6:   ; CHECKING 3, 6, 9
        MOV AL, O3
        MOV BL, O6 
        MOV CL, O9
                
        CMP AL, BL
        JNE CHECK7
                
        CMP BL, CL
        JNE CHECK7
            
        MOV DONE, 1
        JMP ENDCHECK
                
    CHECK7:   ; CHECKING 1, 5, 9
        MOV AL, O1
        MOV BL, O5 
        MOV CL, O9
                
        CMP AL, BL
        JNE CHECK8
                
        CMP BL, CL
        JNE CHECK8
            
        MOV DONE, 1
        JMP ENDCHECK  
                
    CHECK8:   ; CHECKING 3, 5, 7
        MOV AL, O3
        MOV BL, O5 
        MOV CL, O7
                
        CMP AL, BL
        JNE CHECKDRAW
                
        CMP BL, CL
        JNE CHECKDRAW
            
        MOV DONE, 1
        JMP ENDCHECK
                
    CHECKDRAW:
        CMP MOVES, 9
        JNE ENDCHECK
        INC DW
                
    ENDCHECK:
    RET
CHECK_GAME ENDP

PRINT_DRAW PROC
    LEA DX, DRAW
    MOV AH, 9
    INT 21H
    
    RET
PRINT_DRAW ENDP

PRINT_WIN PROC
    CMP PLAYER, 'X'
    JNE PL_X
    LEA DX, WINO
    MOV AH, 9
    INT 21H
    JMP END_PRINT
    
    PL_X:
        LEA DX, WINX
        MOV AH, 9
        INT 21H     
            
    END_PRINT:
    RET    
PRINT_WIN ENDP

END MAIN  

