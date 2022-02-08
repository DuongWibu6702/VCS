section	.bss
    inStr: resb 32	

section .text
    global _start

_start:
    
    getString:				;nhap string
    mov eax, 3	
    mov ebx, 0
    mov ecx, inStr
    mov edx, 32
    int	0x80

    uppercaseString:
    mov ebx, inStr			;thanh ghi ebx luu String
    mov ecx, ebx			;thanh ghi ecx luu gia tri cua String de duyet
    loop:
        cmp byte[ecx], 0		;Duyet xong String
        jz printString
        cmp byte[ecx], 'a'		;if [ecx] < 'a'
        jl next
        cmp byte[ecx], 'z'		;if [ecx] > 'z'
        jg next
        sub byte[ecx], 20h		;viet hoa [ecx]
        
    next: 
        inc ecx				;Duyet ki tu tiep theo trong string
        jnz loop
    
    printString:			;in xau sau khi viet hoa
    mov eax, 4
    mov ebx, 1
    mov ecx, inStr
    mov edx, 32
    int	0x80
    
    mov eax, 1
    int	0x80
