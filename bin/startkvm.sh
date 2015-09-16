#!/bin/bash

sudo kvm -kernel ~/develop/linux/arch/x86/boot/bzImage \
	-append "root=/dev/vda1 rw console=ttyS0 loglevel=8" \
	-initrd initramfs.cpio.gz \
	-nographic \
	-drive index=0,file=ubuntu.qcow2,if=virtio \
 	-drive index=1,file=docker-dm.qcow2,if=virtio \
	-m 4096 -smp 4 -cpu Nehalem,+rdtscp,+tsc-deadline \
	-redir tcp:5555::22
