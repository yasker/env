#!/bin/bash
# Script to clean up completed pods
# One line script as:
# kubectl ${ns_arg} get pod --field-selector "status.phase=Succeeded" -o=custom-columns=:.metadata.name | sed -n '1!p' |xargs kubectl ${ns_arg} delete pod
#
# $1 specified namespace

set -e

ns_arg=""
if [ -n "$1" ]
then
    ns_arg="-n $1"
fi

pods=`kubectl ${ns_arg} get pod --field-selector "status.phase=Succeeded" -o=custom-columns=:.metadata.name | sed -n '1!p'`

if [ -z "$pods" ]
then
	echo Nothing to clean up
	exit 0
fi

kubectl ${ns_arg} delete pod ${pods}

echo Clean up done
