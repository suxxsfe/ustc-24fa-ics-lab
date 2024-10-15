.ORIG x3000
; R5 input / return value
; R6 stack top

JSR BEGIN

GET_S ; R0 n, R1 answer
    STR R0, R6, x0
    STR R1, R6, x1
    STR R7, R6, x2
    ADD R6, R6, x3

    AND R1, R1, x0
    ADD R0, R5, x0
    BRz IS_ZERO_S
        ADD R0, R0, x-1
        
        ADD R5, R0, x0; S(n-1)
        JSR GET_S
        ADD R1, R1, R5
        
        ADD R5, R0, x0; Earn(n-1)
        JSR GET_EARN
        ADD R1, R1, R5
        
        ADD R5, R0, x0; Spend(n-1)
        JSR GET_SPEND
        NOT R5, R5
        ADD R5, R5, x1
        ADD R1, R1, R5  ; R1 <- R1-R5
        JSR IS_ZERO_S_END
    IS_ZERO_S
        ADD R1, R1, xa
    IS_ZERO_S_END
        
    ADD R5, R1, x0
    LDR R7, R6, x-1
    LDR R1, R6, x-2
    LDR R0, R6, x-3
    ADD R6, R6, x-3
    RET

GET_EARN ; R0 n, R1 answer
    STR R0, R6, x0
    STR R1, R6, x1
    STR R7, R6, x2
    ADD R6, R6, x3

    AND R1, R1, x0
    ADD R0, R5, x0
    BRz IS_ZERO_EARN
        ADD R0, R0, x-1
        ADD R5, R0, x0; Earn(n-1)
        JSR GET_EARN
        ADD R1, R5, R5
        JSR IS_ZERO_EARN_END
    IS_ZERO_EARN
        ADD R1, R1, x5
    IS_ZERO_EARN_END
        
    ADD R5, R1, x0
    LDR R7, R6, x-1
    LDR R1, R6, x-2
    LDR R0, R6, x-3
    ADD R6, R6, x-3
    RET

GET_SPEND ; R0 n, R1 answer, R2 Earn(n-1), R3 Spend(n-1)
    STR R0, R6, x0
    STR R1, R6, x1
    STR R2, R6, x2
    STR R3, R6, x3
    STR R7, R6, x4
    ADD R6, R6, x5

    AND R1, R1, x0
    ADD R0, R5, x0
    BRz IS_ZERO_SPEND
        ADD R0, R0, x-1
        
        Add R5, R0, x0; Earn(n-1)
        JSR GET_EARN
        ADD R2, R5, x0
        
        ADD R5, R0, x0; Spend(n-1)
        JSR GET_SPEND
        ADD R3, R5, x0
        
        NOT R3, R3
        ADD R3, R3, x1
        ADD R2, R2, R3; R2 = earn - spend
        BRnz RESET_SPEND
            ADD R3, R3, x-1
            NOT R3, R3
            ADD R3, R3, R3; Spend(n-1)*4
            ADD R3, R3, R3
            ADD R1, R3, x0
            JSR RESET_SPEND_END
        RESET_SPEND
            ADD R1, R1, x2
        RESET_SPEND_END
        JSR IS_ZERO_SPEND_END
    IS_ZERO_SPEND
        ADD R1, R1, x2
    IS_ZERO_SPEND_END
        
    ADD R5, R1, x0
    LDR R7, R6, x-1
    LDR R3, R6, x-2
    LDR R2, R6, x-3
    LDR R1, R6, x-4
    LDR R0, R6, x-5
    ADD R6, R6, x-5
    RET

BEGIN:
    LDI R0, INPUT
    LD R6, STACK
    
    ADD R5, R0, x0
    JSR GET_S
    LD R0, RESULT
    STR R5, R0, x0
    
    TRAP x25

STACK .FILL x6000
INPUT .FILL X3100
RESULT .FILL X3200
.END

;.ORIG x3100
;.FILL #10
;.END
