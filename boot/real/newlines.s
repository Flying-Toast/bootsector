.code16

.set NL, 10 # newline
.set CR, 13 # carriage return

.entry:
	mov $0xE, %ah
.restart:
	mov $0, %bx
.top:
	mov .chars(%bx), %al
	cmp $0, %al
	jne .continue
	mov $NL, %al
	int $0x10
	mov $CR, %al
	int $0x10
	jmp .restart
.continue:
	int $0x10
	inc %bx
	jmp .top

.chars:
	.asciz "hello"
