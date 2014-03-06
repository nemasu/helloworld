
section .data
	helloworld  db "Hello World!",10,0
	hw_size 	equ $ - helloworld

section .text
    global  _start

_start:
	mov rdx, hw_size
	mov rsi, helloworld
	mov rdi, 1
	mov rax, 1
	syscall

	mov rdi, 0
	mov rax, 60
	syscall
