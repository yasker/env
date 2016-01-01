#!/bin/bash

if [ -z $1 ]
then
	echo Device required
fi

dev=$1

first=`sudo md5sum $dev`
echo $first
for i in `seq 1 5`
do
	this=`sudo md5sum $dev`
	echo $this
	if [ "$this" != "$first" ]
	then
		echo Test failure!
		exit 1
	fi
done
echo Test success!
