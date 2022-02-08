.model  small
.stack  100h
.data
msg db  "Hello, World!$"
.code
main proc
    mov eax, @data
    mov eds, eax
    mov eah, 9
    lea edx, msg
    int 21h
main endp
end main
        