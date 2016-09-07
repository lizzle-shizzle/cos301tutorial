		segment	.bss
opOne	resq		7
opTwo	resq		7
opRas	resq		1
spOne	resq		1
spTwo	resq		1
opAns	resq		15
opSig	resq		1
		
		segment	.data
mult	dd			42
plus	dd			43
subt	dd			45
divi		dd			47

		segment	.text
global _start
_start:
		mov		rax, 0
		mov		rdi, 0
		mov		rsi, opOne
		mov		rdx, 7
		syscall
		
		mov		rax, 0
		mov		rdi, 0
		mov		rsi, spOne
		mov		rdx, 1
		syscall
		
		mov		rax, 0
		mov		rdi, 0
		mov		rsi, opRas
		mov		rdx, 1
		syscall
		
		mov		rax, 0
		mov		rdi, 0
		mov		rsi, spTwo
		mov		rdx, 1
		syscall
		
		mov		rax, 0
		mov		rdi, 0
		mov		rsi, opTwo
		mov		rdx, 8
		syscall
		
		mov		r8, [mult]
		cmp		[opRas], r8
		jz			ifmult
		
		mov		r8, [plus]
		cmp		[opRas], r8
		jz			ifplus
		
		mov		r8, [subt]
		cmp		[opRas], r8
		jz			ifsubr
		
		mov		r8, [divi]
		cmp		[opRas], r8
		jz			ifdivi
		
		ifmult:
			jmp	endOp
			
		ifplus:
			jmp	endOp
		
		ifsubr:
			mov 	r9, [opOne]
			
			jmp	endOp
			
		ifdivi:
			jmp	endOp
		
		endOp:
		
		mov		rax, 60
		xor			rdi, rdi
		syscall
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		