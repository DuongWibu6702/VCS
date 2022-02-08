section	.data
    msg	db	'Hello, World!',0xa	;Khai bao string
    len	equ	$ - msg			;Khai bao do dai string

section	.text
	global _start

_start:
   	mov	eax, 4			;sys_write
   	mov	ebx, 1			;std_out
  	mov	ecx, msg		;thanh ghi ecx chua string
	mov	edx, len		;thanh ghi edx chua do dai string
	int	0x80			;syscall

	mov	eax, 1			;exit
	int	0x80