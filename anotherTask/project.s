.data
arr dw 1, 5, 2, 8, 9, 3, 6, 7, 4, 0

.code
main proc
    mov cx, 10   ; initialize loop counter
    mov si, 0    ; initialize array index

sort_loop:
    mov ax, arr[si]
    cmp ax, arr[si+2]
    jle skip_swap
    xchg ax, arr[si+2]
    mov arr[si], ax

skip_swap:
    add 
