	.file	"bilbo.c"

	.text
	.globl	xzero
	.type	xzero, @function
xzero:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	$0, count@GOTOFF(%eax)
    leave
	ret

	.globl	xinc
	.type	xinc, @function
xinc:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	addl	$1, count@GOTOFF(%eax)
    leave
	ret

	.globl	xdec
	.type	xdec, @function
xdec:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	subl	$1, count@GOTOFF(%eax)
    leave
	ret

	.globl	xvalue
	.type	xvalue, @function
xvalue:
    enter   $0,$1
	call	get_pc
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	count@GOTOFF(%eax), %eax
    leave
	ret

	.data
	.align 4
	.type	count, @object
	.size	count, 4
count:
	.long	13

	.section	.text.get_pc,"axG",@progbits,get_pc,comdat
	.globl	get_pc
	.hidden	get_pc
	.type	get_pc, @function
get_pc:
    enter   $0,$1
	movl	4(%ebp), %eax
    leave
	ret
