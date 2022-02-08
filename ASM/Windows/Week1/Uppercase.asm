.model small
.stack 100h
.data 
    _str db 32 dup('$')
.code
    main proc
        mov ax, @data
        mov ds, ax

        mov ah, 10
        lea dx, _str
        int 21h

        lea dx, _str + 2
        int 21h

        mov ah, 4ch
        int 21h
    main endp
end main