#!/bin/bash

if [ -z $1 ]
then
	echo Bad arguments.
	echo "    Usage: $(basename $0) <input.s>"
	exit 1
fi

if mkbootdisk $1
then
	qemu-system-x86_64 -monitor stdio -drive format=raw,file=bootdisk.bin
else
	echo Failed because of above errors
fi
