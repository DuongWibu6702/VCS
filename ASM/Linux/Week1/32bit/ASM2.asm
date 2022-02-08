section	.bss
    inputString resb 32		;Khai bao bien String 32 ki tu

section .text
    global _start

_start:
    
getString:			;Nhap string
    mov eax, 3			;sys_read
    mov ebx, 0			;stdin
    mov ecx, inputString	
    mov edx, 32
    int	0x80

printString:			;In string
    mov eax, 4			;sys_write
    mov ebx, 1			;stdout
    mov ecx, inputString
    mov edx, 32
    int	0x80

exit:
    mov eax, 1			;exit code 0
    int	0x80