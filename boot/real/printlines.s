.code16

.set NL, 10 # newline
.set CR, 13 # carriage return
.set LINES, 10 # how many lines to print

.entry:
	mov $0xE, %ah
	mov $0, %cx
.restart:
	mov $0, %bx
.top:
	mov .chars(%bx), %al
	cmp $0, %al
	jne .continue
	inc %cx
	mov $NL, %al
	int $0x10
	mov $CR, %al
	int $0x10
	cmp $LINES, %cx
	je .end
	jmp .restart
.continue:
	int $0x10
	inc %bx
	jmp .top

.end:
	jmp .end

.chars:
	.asciz "hello"
