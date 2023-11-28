	.file	"bilbo.c"

	.data
	.align 4
fubar:
	.long	31

count:
	.long	42

	.text
	.globl	xzero
xzero:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
    lea     count@GOTOFF(%eax), %eax
	movl	$0, (%eax)
    leave
	ret

	.globl	xinc
xinc:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
    lea     count@GOTOFF(%eax), %eax
	addl	$1, (%eax)
    leave
	ret

	.globl	xdec
xdec:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
    lea     count@GOTOFF(%eax), %eax
	subl	$1, (%eax)
    leave
	ret

	.globl	xvalue
xvalue:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
    lea     count@GOTOFF(%eax), %eax
	movl	(%eax), %eax
    leave
	ret

	.section	.text.get_pc,"axG",@progbits,get_pc,comdat
	.globl	get_pc
	.hidden	get_pc
get_pc:
    enter   $0,$1
	movl	4(%ebp), %eax
    leave
	ret
