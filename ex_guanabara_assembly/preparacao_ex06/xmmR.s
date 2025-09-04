	.file	"xmmRegisters.c"
	.intel_syntax noprefix
	.text
	.globl	xmm
	.bss
	.align 16
	.type	xmm, @object
	.size	xmm, 16
xmm:
	.zero	16
	.section	.rodata
.LC1:
	.string	"%0.1f \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 16
	mov	DWORD PTR -4[rbp], edi
	mov	QWORD PTR -16[rbp], rsi
	mov	DWORD PTR xmm[rip], 1
	mov	BYTE PTR xmm[rip+4], 2
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR xmm[rip+8], xmm0
	mov	rax, QWORD PTR xmm[rip+8]
	movq	xmm0, rax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	1374389535
	.long	1074339512
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
