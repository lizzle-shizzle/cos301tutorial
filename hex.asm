	segment	.bss
in1 	resq		1
in2 	resq		1
res 	resq		1
	
	segment	.data
el	db	 		10
cr	db			13
nl  dq			0x0a
	segment	.text
global _start

_start:
	mov		rax, 0
	mov		rdi, 0
	mov		rsi, in1
	mov		rdx, 1
	syscall
	
	mov		rax, 0
	mov		rdi, 0
	mov		rsi, in2
	mov		rdx, 1
	syscall
	
	mov		rax, 0
	mov		rdi, 0
	mov		rsi, el
	mov		rdx, 1
	syscall
	
	mov		r8, '9'
	mov		r9, [in1]
	
	cmp 		[in1], r8
	jg 			else1
	sub		r9, 48 
	mov	[in1], r9
	jmp		endif1

	else1:
		sub		r9, 87
		mov	[in1], r9

	endif1:	
		mov		r9, [in2]
		cmp		[in2], r8
		jg 			else2
		sub 	r9, 48
		mov	[in2], r9
		jmp		endif2

	else2:
		sub 	r9, 87
		mov	[in2], r9

	endif2:
	
	mov	 	rax, 4
	mov		r9, [in1]
	for:
		cmp	rax, 0
		jz		endfor
			sal		r9, 1
			dec		rax
		jmp		for

	endfor:	
		mov		r10, r9
		add			r10, [in2]
		mov		[res], r10
		
		mov		rax, 1
		mov		rdi, 1
		mov		rsi, res
		mov		rdx, 2
		syscall
		
		mov		rax, 1
		mov		rdi, 1
		mov		rsi, el
		mov		rdx, 2
		syscall
		
		mov		rax, 1
		mov		rdi, 1
		mov		rsi, cr
		mov		rdx, 2
		syscall
		
		not			r10b
		sar			r10, 1
		mov		[res], r10
		
		mov		rax, 1
		mov		rdi, 1
		mov		rsi, res
		mov		rdx, 2
		syscall

		mov		rax, 60
		xor		rdi, rdi
		syscall

		jmp output

	output: 
		mov rax, 1
		mov rdi, 1
		mov rsi, nl
		mov rdx, 1
		syscall
