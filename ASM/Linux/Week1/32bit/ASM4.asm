section	.bss
    a: resb 10
    b: resb 10

section .text
    global _start

_start:
    
    mov eax, 3			;nhap a
    mov ebx, 0
    mov ecx, a
    mov edx, 10
    int	0x80
    
    mov eax, 3			;nhap b
    mov ebx, 0
    mov ecx, b
    mov edx, 10
    int 0x80
    
    mov eax, a			
    call atoi			;chuyen a tu string sang int
    add ebx, eax		;ebx += eax
    
    mov eax, b
    call atoi			;chuyen b tu string sang int
    add eax, ebx		;eax += ebx
    
    call iprint			;in eax theo dinh dang int
    
    mov eax, 1			;exit
    int	0x80
    
atoi:
    push    ebx             ; chuyen ebx, ecx, edx, esi vao stack de dung sau khi ham dc thuc hien
    push    ecx
    push    edx
    push    esi
    mov     esi, eax
    mov     eax, 0          ; eax = 0
    mov     ecx, 0          ; ecx = 0
 
.multiplyLoop:
    xor     ebx, ebx        ; dua bl va bh ve 0
    mov     bl, [esi+ecx]   ; dua 1 byte vao bl
    cmp     bl, 48
    jl      .finished       ; if bl < 48 ('0')
    cmp     bl, 57         
    jg      .finished       ; if bl > 57 ('9')
 
    sub     bl, 48          ; chuyen bl tu string sang int
    add     eax, ebx        ; eax += ebx
    mov     ebx, 10         ; ebx = 10
    mul     ebx             ; eax *= ebx
    inc     ecx             ; tang bien dem ecx
    jmp     .multiplyLoop   ; tiep tuc lap
 
.finished:
    cmp     ecx, 0          ; dieu kien dung
    je      .restore
    mov     ebx, 10         ; ebx = 10
    div     ebx             ; eax /= ebx
 
.restore:
    pop     esi             ; khoi phuc ebx, ecx, edx, esi 
    pop     edx             
    pop     ecx             
    pop     ebx            
    ret
    
slen:
    push    ebx
    mov     ebx, eax
 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    sub     eax, ebx
    pop     ebx
    ret
 
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret
    
iprint:
    push    eax            
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          ; bien dem
 
divideLoop:
    inc     ecx             ; tang bien dem
    mov     edx, 0          ; edx = 0
    mov     esi, 10         ; esi = 19
    idiv    esi             ; eax /= esi
    add     edx, 48         ; chuyen edx thanh string deo in ra
    push    edx             ; dua edx vao stack
    cmp     eax, 0          ; dieu kien dung
    jnz     divideLoop
 
printLoop:
    dec     ecx             ; count down each byte that we put on the stack
    mov     eax, esp        ; dua con tro stack vao eax de in ra
    call    sprint     	
    pop     eax		    ; day 1 phan tu ra khoi stack
    cmp     ecx, 0	    ; dieu kien dung
    jnz     printLoop
 
    pop     esi            
    pop     edx        
    pop     ecx    
    pop     eax   
    ret
