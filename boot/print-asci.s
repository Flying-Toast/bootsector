.code16

.ENTRY:
	mov $0, %al
.TOP:
	cmp $255, %al
	je .END
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
