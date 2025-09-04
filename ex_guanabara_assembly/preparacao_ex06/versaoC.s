	.file	"versaoC.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "%f\0"
	.align 4
LC2:
	.ascii "O dobro eh: %.0f\12OTriplo eh: %.0f\12A raiz quadrada eh: %.5f\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB10:
	.cfi_startproc
	push	ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	mov	ebp, esp
	.cfi_def_cfa_register 5
	and	esp, -16
	sub	esp, 48
	call	___main
	lea	eax, [esp+44]
	mov	DWORD PTR [esp+4], eax
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_scanf
	fld	DWORD PTR [esp+44]
	fstp	QWORD PTR [esp]
	call	_sqrt
	fld	DWORD PTR [esp+44]
	fld	DWORD PTR LC1
	fmulp	st(1), st
	fld	DWORD PTR [esp+44]
	fadd	st, st(0)
	fxch	st(2)
	fstp	QWORD PTR [esp+20]
	fstp	QWORD PTR [esp+12]
	fstp	QWORD PTR [esp+4]
	mov	DWORD PTR [esp], OFFSET FLAT:LC2
	call	_printf
	mov	eax, 0
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE10:
	.section .rdata,"dr"
	.align 4
LC1:
	.long	1077936128
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_sqrt;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
