section .bss
    S: resb 256


section	.text
	global _start       ;must be declared for using gcc
	
_start:                     ;tell linker entry point
	
	mov eax, 3
	mov ebx, 0
	mov ecx, S
	mov edx, 256
	int 0x80
	
	mov eax, S
	call sprint
	
	mov eax, 4
	mov ebx, 1
	mov ecx, S
	mov edx, 256
	int 0x80
	
	call quit

slen:
    push    ebx
    mov     ebx, eax
 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    dec     eax
    pop     ebx
    ret
 
 

sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     ebx, eax
    pop     eax
    
nloop:
    cmp     eax, ebx
    jge     done
    
    mov cl, byte[eax]      ; put char from eax in cl
    mov ch, byte[ebx]      ; put char from edx in ch
    sub [ebx], ch      ; put cl in edx
    add [ebx], cl
    sub [eax], cl      ; put ch in eax
    add [eax], ch

    inc     eax
    dec     ebx
    jmp nloop
 
done:

    pop     ebx
    pop     ecx
    pop     edx
    ret
 
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret
