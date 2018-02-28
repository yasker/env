#!/bin/bash

files=`find ~/develop/go/src/github.com/rancher/longhorn-manager/deploy/ |grep yaml |sort`
rm -f result.yaml
for f in $files
do
	echo $f
	cat $f >> result.yaml
	echo --- >> result.yaml
done
