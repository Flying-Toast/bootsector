#!/bin/bash

if mkbootdisk main.s
then
	qemu-system-x86_64 -monitor stdio -drive format=raw,file=bootdisk.bin
fi
