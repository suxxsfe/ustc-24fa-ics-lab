.ORIG x3000
; R0 input/output
; R1 state
; R2 answer
; R3 length of seq
; R5 address
; R6 -48 xD7CB

LD R6, COMPLEMENT

LDI R5, WELCOM
LOOP_WELCOM     ; output welcom message
    LDR R0, R5, x0
    BRz END_LOOP_WELCOM
    TRAP x21
    ADD R5, R5, x1
    JSR LOOP_WELCOM
END_LOOP_WELCOM

AND R3, R3, x0
LOOP_NUMBER
    TRAP x20
    ADD R0, R0, R6
    BRn END_LOOP_NUMBER
    ADD R4, R3, x0
    ADD R4, R4, R4
    ADD R3, R4, R4
    ADD R3, R3, R3
    ADD R3, R3, R4 ; R3 *= 10
    ADD R3, R3, R0
END_LOOP_NUMBER

AND R1, R1, x0
AND R2, R2, x0
LOOP_SEQ
    TRAP x20
    ADD R0, R0, R6
    ADD R0, R0, x-1; 2' complement of 49(ascii 1)
    BRp END_LOOP_SEQ
    ADD R0, R0, x1
    
    LDI R5, TRANS
    ADD R5, R5, R1
    ADD R5, R5, R1
    ADD R5, R5, R1
    ADD R5, R5, R0; new state = trans[state*3+number]
    LDR R1, R5, x0
    LDR R3, R5, x2; answer = trans[state*3+2]
    ADD R2, R2, R3
END_LOOP_SEQ


LDI R5, ANSWER
STR R2, R5, x0
LDI R5, RESULT
LOOP_RESULT ;    output the result
    LDR R0, R5, x0
    ADD R0, R0, x1
    BRz END_LOOP_RESULT
    ADD R0, R0, x-1
    TRAP x21
    ADD R5, R5, x1
    JSR LOOP_RESULT
END_LOOP_RESULT

TRAP x25
.END

.ORIG x3050
COMPLEMENT
    .FILL xD7CB
    
WELCOM
    .FILL #83
    .FILL #68
    .FILL #32
    .FILL #105
    .FILL #115
    .FILL #32
    .FILL #114
    .FILL #101
    .FILL #97
    .FILL #100
    .FILL #121
    .FILL #33
    .FILL #32
    .FILL #80
    .FILL #108
    .FILL #101
    .FILL #97
    .FILL #115
    .FILL #101
    .FILL #32
    .FILL #105
    .FILL #110
    .FILL #112
    .FILL #117
    .FILL #116
    .FILL #32
    .FILL #121
    .FILL #111
    .FILL #117
    .FILL #114
    .FILL #32
    .FILL #110
    .FILL #117
    .FILL #109
    .FILL #98
    .FILL #101
    .FILL #114
    .FILL #58
    .FILL #0
    
RESULT
    .FILL #84   ; T
    .FILL #104  ; h
    .FILL #101  ; e
    .FILL #114  ; r
    .FILL #101  ; e
    .FILL #32   ; (空格)
    .FILL #97   ; a
    .FILL #114  ; r
    .FILL #101  ; e
    .FILL #40   ; (
    .FILL #105  ; i
    .FILL #115  ; s
    .FILL #41   ; )
    .FILL #32   ; (空格)

ANSWER    
    .FILL #0    ; answer
    
    .FILL #32   ; (空格)
    .FILL #49   ; 1
    .FILL #48   ; 0
    .FILL #49   ; 1
    .FILL #48   ; 0
    .FILL #32   ; (空格)
    .FILL #105  ; i
    .FILL #110  ; n
    .FILL #32   ; (空格)
    .FILL #116  ; t
    .FILL #104  ; h
    .FILL #101  ; e
    .FILL #32   ; (空格)
    .FILL #115  ; s
    .FILL #101  ; e
    .FILL #113  ; q
    .FILL #117  ; u
    .FILL #101  ; e
    .FILL #110  ; n
    .FILL #99   ; c
    .FILL #101  ; e
    .FILL #33   ; !
    .FILL #-1

TRANS
    .FILL x0
    .FILL x1
    .FILL x0
    
    .FILL x2
    .FILL x1
    .FILL x0
    
    .FILL x0
    .FILL x3
    .FILL x0
    
    .FILL x4
    .FILL x1
    .FILL x0
    
    .FILL x0
    .FILL x3
    .FILL x1

.END
