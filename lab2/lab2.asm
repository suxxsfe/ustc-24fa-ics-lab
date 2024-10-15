.ORIG x3000
;R0 answer
;R1 k
;R2 new k
;R5 BaseR

AND R5, R5, x0
ADD R5, R5, xc ;x3 * 4
ADD R5, R5, R5
ADD R5, R5, R5 ;x30
ADD R5, R5, x1
ADD R5, R5, R5
ADD R5, R5, R5
ADD R5, R5, R5
ADD R5, R5, R5 ;x310
ADD R5, R5, R5
ADD R5, R5, R5
ADD R5, R5, R5
ADD R5, R5, R5 ;3100
LDR R1, R5, x0
AND R0, R0, x0

LOOP
    ADD R2, R1, x-1
    BRz END
    AND R3, R1, x1
    BRz EVEN           ; odd case
        ADD R2, R1, R1
        ADD R2, R2, R1
        ADD R1, R2, x1
    JSR CONTINUE
    EVEN               ; even case
        AND R2, R2, x0
        ADD R3, R2, x2
        ADD R4, R2, x1
        EVEN_LOOP
            AND R6, R1, R3
            BRz ZERO_BIT    ; this bit is 1
                ADD R2, R2, R4
            ZERO_BIT
            ADD R4, R4, R4
            ADD R3, R3, R3
        BRnp EVEN_LOOP
        ADD R1, R2, x0
    CONTINUE
    ADD R0, R0, x1
JSR LOOP
END

STR R0, R5, x1

TRAP x25
.END
