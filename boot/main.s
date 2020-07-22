.code16

.ENTRY:
	mov $1, %al
.TOP:
	cmp $100, %al
	jg .END
	call .PUTC
	inc %al
	jmp .TOP

.END:
	jmp .END

.PUTC:
	push %ax
	mov $0xE, %ah
	int $0x10
	pop %ax
	ret
