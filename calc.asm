section .data	
	space db ' '
	rem db 'r'
	plus db '+'
	minus db '-'
	newline db 10
	value1 dq 0

segment .bss
num resq 1

var resb 1
sign resb 1
value2 resd 1


	
segment .text
global _start
_start:

	xor r8,r8
	mov r9,6
	mov r10,10
	xor r15,r15

read:
	
	xor eax,eax
	xor edi,edi
	mov rsi, var
	mov rdx, 1
	syscall
	
	dec r9
	mov r14,r9
	movsx rax,byte[var]
	sub rax,'0'
	cmp r9,0
	je save
	cmp rax,0
	je read
	jmp digit
	
digit:
	cmp r14,0
	je hold
	mul r10
	dec r14
	jmp digit

hold:
	add r15,rax
	jmp read
	
save:	
	add r15,rax
	cmp r8,0
	je savefirst
	mov [value2],r15
	
	
	
	jmp calc
	
savefirst:	
	inc r8
	
	
	
	mov [value1],r15
	
	mov r9,6
	xor r15,r15
	
	jmp getSign
	
getSign:	
	xor eax,eax
	xor edi,edi
	mov rsi, var
	mov rdx, 1
	syscall
	
	xor eax,eax
	xor edi,edi
	mov rsi, sign
	mov rdx, 1
	syscall
	
	xor eax,eax
	xor edi,edi
	mov rsi, var
	mov rdx, 1
	syscall
	jmp read

negative:
	neg qword[num]
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,minus
	syscall
	mov r14,12
	
	jmp toDec


calc:
	xor r15,r15
	
	mov rax, [value1]
	movzx r8,byte [sign]
	
	cmp r8,'-'
	je subtracting
	cmp r8,'*'
	je multiplying
	cmp r8,'/'
	je dividing
	cmp r8,'+'
	jne terminate

	
	add rax,[value2]
	mov [num],rax
	jmp positive
subtracting:
	sub rax,[value2]
	mov [num],rax
	cmp rax,0
	jl negative
	jmp positive
multiplying:
	mov r9,[value2]
	mul r9
	mov [num],rax
	jmp positive
dividing:	
	xor edx,edx
	mov r9,[value2]
	div r9
	mov [num],rax
	mov r15,rdx

positive:
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,plus
	syscall
	mov r14,12
	
toDec:
	cmp r14,0
	je print 
	
	mov r9,r14
	mov rax, [num]
	dec r14
	
	
forloop:
	xor edx,edx
	div r10
	sub r9,1
	cmp r9,0
	jne forloop
	
	
	add rdx,'0'
	mov [var],rdx
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,var
	syscall
	jmp toDec
	
print:
	
	
	cmp r15,0
	je terminate
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,space
	syscall
	
	
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,rem
	syscall
	
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,space
	syscall
	
	add r15,'0'
	mov [var],r15
	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,var
	syscall

terminate:
	mov eax, 1
	mov edi, 1
	mov edx, 5;Number of characters to be stored
	lea rsi, "ERROR"
	syscall

	mov rax,1
	mov rdi,1
	mov rdx,1
	mov rsi,newline
	syscall
	
	xor eax,eax
	xor edi,edi
	mov rsi, var
	mov rdx, 2
	syscall
	
	mov rax,60
	xor edi,edi
	syscall