.code16

.entry:
	mov $0xE, %ah
	mov $0, %al
.top:
	cmp $255, %al
	je .end
	int $0x10
	inc %al
	jmp .top

.end:
	jmp .end
