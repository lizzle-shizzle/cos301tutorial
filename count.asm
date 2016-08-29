	segment	.bss
inp 	resb		1
	
	segment	.data
el	db	 		10
	segment	.text
global _start

_start:
	mov		rax, 0
	mov		rdi, 0
	mov		rsi, inp
	mov		rdx, 1
	syscall
	
	mov		rax, 0
	mov		rdi, 0
	mov		rsi, el
	mov		rdx, 1
	syscall
	
	mov		r10, 10
	mov		r8, [inp]
	for:
		cmp	r10, 0
		jz		endfor
			mov		rax, 1
			mov		rdi, 1
			mov		rsi, inp
			mov		rdx, 1
			syscall
			
			add			r8, 1
			mov		[inp], r8
			dec			r10
			
			cmp		r8, 57
			jnz			endif
				add		r8, 39
				jmp 	for
			endif:
			
			cmp		r8, 123
			jz			endfor
		jmp for
	endfor:
	
	mov		rax, 1
	mov		rdi, 1
	mov		rsi, el
	mov		rdx, 1
	syscall
	
	mov 		rax, 60
	xor			rdi, rdi
	syscall