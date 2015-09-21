#!/bin/bash

sudo kvm -kernel ~/develop/linux/arch/x86/boot/bzImage \
	-append "root=/dev/vda1 rw console=tty0 console=ttyS0 ignore_loglevel" \
	-drive index=0,file=ubuntu.qcow2,if=virtio \
 	-drive index=1,file=docker-dm.qcow2,if=virtio \
	-initrd initramfs.cpio.gz \
	-nographic \
	-m 4096 -smp 4 -cpu Nehalem,+rdtscp,+tsc-deadline \
	-redir tcp:5555::22
