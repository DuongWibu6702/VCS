section	.bss
    inputString resb 32

section .text
    global _start

_start:
    call _getString
    call _printString
    
    mov rax, 1
    int	0x80
    
_getString:
    mov rax, 3
    mov rbx, 0
    mov rcx, inputString
    mov rdx, 32
    int	0x80
    ret
