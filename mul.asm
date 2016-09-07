		segment	.data
in1		dq			0
in2		dq			0
sum		dq			0
off		dq			48
		segment	.text
		global _start

_start:
		mov		rax,0
		mov		rdi,0
		mov		rsi,in1
		mov		rdx,2
		syscall
		
		mov		rax,0
		mov		rdi,0
		mov		rsi,in2
		mov		rdx,2
		syscall
		
		mov		rax,[off]
		sub		[in1],rax
		sub		[in2],rax
		syscall
		
		mov		rax,[in1]
		imul	rax,[in2]
		mov		[sum],rax
		mov		rax,[off]
		add		[sum],rax
		syscall
		
		mov		rax,1
		mov		rdi,1
		mov		rsi,sum
		mov		rdx,1
		syscall
		
		mov		rax,60
		xor		rdi,rdi
		syscall