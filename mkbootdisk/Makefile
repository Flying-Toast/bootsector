OBJECTS=main.o
CC=gcc

mkbootdisk: $(OBJECTS)
	$(CC) -O3 -o mkbootdisk $(OBJECTS)

.PHONY: clean
clean:
	-rm bootdisk.bin
	-rm mkbootdisk
	-rm $(OBJECTS)

.PHONY: install
install: mkbootdisk
	-rm ~/.local/bin/mkbootdisk
	cp mkbootdisk ~/.local/bin/mkbootdisk
