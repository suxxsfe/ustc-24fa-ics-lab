.ORIG x3000
; R1 begin
; R2 end
; R5 result

LD R5, RESULT
LDI R0, LENGTH
LD R1, STRING
ADD R2, R1, R0
ADD R2, R2, x-1

LOOP
    ; if R2 <= R1, end loop
    NOT R3, R2
    ADD R3, R3, x1
    ADD R4, R1, R3 ; R4 = R1-R2
    BRzp END_LOOP

    LDR R3, R1, x0
    LDR R4, R2, x0
    NOT R4, R4
    ADD R4, R4, x1
    ADD R3, R3, R4
    BRnp FAIL
    
    ADD R1, R1, x1
    ADD R2, R2, x-1
JSR LOOP
END_LOOP

; R0 : result
AND R0, R0, x0
ADD R0, R0, x1
JSR END
FAIL
AND R0, R0, x0

END
STR R0, R5, x0
TRAP x25

LENGTH .FILL x3100
STRING .FILL x3101
RESULT .FILL x3200
.END
