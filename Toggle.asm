; A simple routine used to toggle the last bit of the contents of R1.
;
; Carl Argabright
; TCSS 371 - Fall 2018


; Begin at x3000
                    .orig x3000
                    LD R1, DATA         ; Load the data to be toggled into R1
                    JSR TOGGLE

                    HALT

; Routines
TOGGLE
                    ST R7, BACKUP_R7
                    AND R7, R1, #1      ; AND R1 with the mask 0000 0000 0000 0001
                    BRp MINUS_ONE       ; If the result is positive we need to subtract #1
                    ADD R1, R1, #1      ; Since the result was zero we add one
                    BRnzp END           ; Load R7 back and return to the caller
MINUS_ONE           ADD R1, R1, #-1     ; Since the result was 1 we need to subtract one for the toggle
END                 LD R7, BACKUP_R7    ; Restore the point at which we entered the
                    RET                 ; routine and return back to the caller


; Variables
DATA                .FILL #7            ; Initial value to be flipped
BACKUP_R7           .BLKW 1             ; A variable to store R7
                                        ; Before: 0000 0000 0000 0111 = 7, After: 0000 0000 0110
                    

                    .END                ; And they lived happily ever after.