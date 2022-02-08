section .bss
    S: resb 256
    c: resb 10


section	.text
	global _start       ;must be declared for using gcc
	
_start:                     ;tell linker entry point
	
	mov eax, 3
	mov ebx, 0
	mov ecx, S
	mov edx, 100
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, c
	mov edx, 10
	
	mov eax, S
loopS:
    cmp byte[eax], 0
    je finished
    
    jmp cmpPos
    
cmpPos:
    push eax
    mov ebx, c
    
loopc:
    cmp byte[ebx], 0
    je getPos
    mov edx, eax
    sub edx, ebx
    cmp byte[edx], 0
    jne break
    inc eax
    inc ebx
    jmp loopc
    
getPos:
    pop eax
    sub ebx, eax
    push ebx
    inc ecx
    ret
    
break:
    pop eax
    ret
    
    
finished:
    
    mov eax, 1
    int 0x80
    
    

