

.model small 
.stack 100h
.DATA  


;welcome message

MSG_WEL DB 0DH,0AH,0DH,0AH, '----Appointments System---- $'
 
;menu
  
OP_1 DB 0DH,0AH,0DH,0AH, ' 1. All the names of the doctors and their information $' 
OP_2 DB 0DH,0AH,0DH,0AH,' 2. Book an appointment $' 
OP_3 DB 0DH,0AH,0DH,0AH, ' 3. Display and calculate the price $' 
OP_4 DB 0DH,0AH,0DH,0AH, ' 4. Exit the application $' 
EXIT_MSG DB 0DH,0AH, '  Thank you!  $'
OPP_Confirm DB 0DH,0AH, '  **The appointment has been booked**  $' 
                        
OP_5 DB 0DH,0AH,0DH,0AH, ' YOUR YOUR CHOICE IS: $' 
OP_6 DB 0DH,0AH,0DH,0AH, ' PRESS ANY KEY TO RETURN MENU $'  
  

Doctor_Info DB 0DH,0AH, "The doctors that are available are:",0DH,0AH,
DB "*************************************************",0DH,0AH
DB "* Doctor name*      Location       *Working hour*",0DH,0AH
DB "*-----------------------------------------------*",0DH,0AH
DB "* Dr.Anna    *  Exit 7, Riyadh St. *  1-3pm     *",0DH,0AH
DB "*-----------------------------------------------*",0DH,0AH
DB "* Dr. Velma  *  Exit 8,Dammam St.  * 9-11am     *",0DH,0AH
DB "*-----------------------------------------------*",0DH,0AH
DB "* Dr. Suzi   *  Exit 9,Jeddah St.  * 10-12pm    *",0DH,0AH
DB "*************************************************",0DH,0AH,"$"
  

                         

APP_INFO db 0DH,0AH," The Available Appointment And Prices : ",0DH,0AH 
 db " **************************************************** ",0DH,0AH 
 db " *Appointment Number* Doctor Name *  Time *  Price  *",0DH,0AH 
 db " *------------------*-------------*-------*---------*",0DH,0AH 
 db " *        1         * Dr. Anna    *1-2pm  * 200 sar *",0DH,0AH 
 db " *------------------*-------------*-------*---------*",0DH,0AH 
 db " *        2         * Dr. Anna    *2-3pm  * 200 sar *",0DH,0AH 
 db " *------------------*-------------*-------*---------*",0DH,0AH 
 db " *        3         * Dr. Velma   *9-10am * 350 sar *",0DH,0AH 
 db " *------------------*-------------*-------*---------*",0DH,0AH 
 db " *        4         * Dr. Velma   *10-11am* 350 sar *",0DH,0AH 
 db " *------------------*-------------*-------*---------*",0DH,0AH 
 db " *        5         * Dr. Suzi    *10-11am* 500 sar *",0DH,0AH 
 db " *------------------*-------------*-------*---------*",0DH,0AH 
 db " *        6         * Dr. Suzi    *11-12pm* 500 sar *",0DH,0AH 
 db " ****************************************************",0DH,0AH,'$'   
      
   
 DISCOUNT_MSG DB 0DH,0AH,0DH,0AH, 'IF YOU ARE STUDENT PRESS 1 FOR 40% OFF : $'      
 TOTAL_PRICE  DB 0DH,0AH,0DH,0AH, 'YOUR TOTAL Bill is :  $'
 
 TOTAL DW 0 
 D60 DW 60 
 D100 DW 100   
 
    
 .CODE 
 MAIN PROC
 ;INITIALIZE DATA SEGMENT. 
 MOV ax, @data 
 MOV ds, ax  
 
 START_APP:   
  
 
 LEA DX, MSG_WEL ; print MSG_WEL 
 MOV AH,9 
 INT 21H 
 
 LEA DX, OP_1 ; print OP_1 
 MOV AH,9 
 INT 21H  
 
 LEA DX, OP_2 ; print OP_2 
 MOV AH,9 
 INT 21H 
  LEA DX, OP_3 ; print OP_3 
 MOV AH,9 
 INT 21H 
 LEA DX, OP_4 ; print OP_4 
 MOV AH,9 
 INT 21H 
 LEA DX, OP_5 ; print OP_5 
 MOV AH,9 
 INT 21H 
 
 
 
 
 
 ;ASK FOR YOUR CHOICE
 MOV AH , 1 
 INT 21H 
 
 CMP AL,"1" 
 JE Doctor_Info1
 
 
 CMP AL,"2" 
 JE APP_INFO1 
 
 
 CMP AL,"3" 
 JE DISP_BILL

 

 CMP AL,"4" 
 JE Exit
 
 
 JMP START_APP  
 
 
 ;option 1 :
 
 Doctor_Info1:  
 LEA dx, Doctor_Info 
 mov ah, 9 
 int 21h 
 LEA DX, OP_6 ; print OP_6 
 MOV AH,9 
 INT 21H
 MOV AH , 1 ; read a first CHOICE 
 INT 21H 
 
 
 JMP START_APP
 
 ;option 2 :
 
 APP_INFO1: 
 LEA dx, APP_INFO 
 mov ah, 9 
 int 21h
RESELECT: 
 LEA DX, OP_5 ; print OP_5 
 MOV AH,9 
 INT 21H 
 MOV AH , 1 ; read a first CHOICE 
 INT 21H 
 CMP AL,'6'
 JA RESELECT
 CMP AL,'0'
 JE RESELECT
 MOV BL,AL
 LEA DX, OPP_Confirm ; print OPP_Confirm 
 MOV AH,9 
 INT 21H
  
       

CMP BL,31H
JE P_200
CMP BL,32H
JE P_200
CMP BL,33H
JE P_350
CMP BL,34H
JE P_350
CMP BL,35H
JE P_500
CMP BL,36H
JE P_500 



P_200: 
LEA DX, TOTAL_PRICE 
MOV AH,9
INT 21H
MOV TOTAL,200
MOV AX, TOTAL
CALL OUTDEC
JMP START_APP
P_350:
LEA DX, TOTAL_PRICE 
MOV AH,9
INT 21H
MOV TOTAL,350
MOV AX,TOTAL 
CALL OUTDEC
JMP START_APP
P_500:
LEA DX,TOTAL_PRICE 
MOV AH,9
INT 21H
MOV TOTAL,500
MOV AX, TOTAL
CALL OUTDEC
JMP START_APP    
        
 
;option 3 :
  
     


DISP_BILL:

LEA DX, TOTAL_PRICE
MOV AH,9
INT 21H
MOV AX,TOTAL
CALL OUTDEC

LEA DX,DISCOUNT_MSG

MOV AH,9
INT 21H
MOV AH , 1
INT 21H
CMP AL, 31H
JE OFF40
JMP DIS

OFF40: 
LEA DX, TOTAL_PRICE
MOV AH,9
INT 21H
MOV AX,TOTAL
MUL D60
DIV D100
MOV TOTAL,AX
CALL OUTDEC

 
JMP START_APP

DIS:

LEA DX, TOTAL_PRICE
MOV AH,9
INT 21H
MOV AX,TOTAL
CALL OUTDEC      
JMP START_APP      
      
      
      
      
      
      
      
 
 ;option 4 :
 
 Exit:  
 
 LEA dx, EXIT_MSG 
 mov ah, 9 
 int 21h 
 
 mov AH,4CH ;EXIT TO>> DOS
 INT 21H

MAIN ENDP  


JMP START_APP

;///ENDMENU /////

 ;code for 


OUTDEC  PROC
PUSH  AX
PUSH  BX
PUSH  CX
PUSH  DX
OR  AX,AX
JGE  @END_IF1
PUSH  AX
MOV  DL,'-'
MOV  AH,2
INT  21H
POP  AX
NEG  AX
@END_IF1:
XOR  CX,CX
MOV  BX,10D
@REPEAT1:
XOR  DX,DX
DIV  BX
PUSH  DX
INC  CX
OR  AX,AX
JNE  @REPEAT1
MOV  AH,2
@PRINT_LOOP:
POP  DX
OR  DL,30H
INT  21H
LOOP  @PRINT_LOOP
POP  DX
POP  CX
POP  BX
POP  AX

RET   

OUTDEC  ENDP




   
 
          
 END MAIN
 

ret

 
 