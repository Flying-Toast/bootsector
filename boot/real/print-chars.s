.code16

.ENTRY:
	mov $0xE, %ah
	mov $0, %al
.TOP:
	cmp $255, %al
	je .END
	int $0x10
	inc %al
	jmp .TOP

.END:
	jmp .END
