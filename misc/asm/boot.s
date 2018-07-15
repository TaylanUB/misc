        [bits 16]
        [org 0x7c00]

main:   
        mov ah, 0x0e
        mov bh, 0x00
        mov bl, 0x07
        mov al, 0x61
        int 0x10
        jmp main

        times 510-($-$$) db 0
        dw 0xaa55
