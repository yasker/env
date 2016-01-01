#!/bin/bash

#set -x
set -e

if [ -z $1 ]
then
	echo Loopback device WWN required
	exit 1
fi

loopback_wwn=$1

tcmu_user=user_1

TCM_PATH=/sys/kernel/config/target
TCMU_PATH=$TCM_PATH/core/$tcmu_user

loopback_path=$TCM_PATH/loopback/$loopback_wwn
if [ ! -d $loopback_path ]
then
	echo Cannot find directory $loopback_path
	exit 1
fi

tpgt_path=$TCM_PATH/loopback/$loopback_wwn/tpgt_1
lun0_path=$tpgt_path/lun/lun_0
dev_name=`find $lun0_path -maxdepth 1 -type l -printf "%f\n"`
if [ "$dev_name" == "" ]
then
	echo Cannot find device name
	exit 1
fi
dev_fe_path=$lun0_path/$dev_name
dev_be_path=$TCMU_PATH/$dev_name

if [ ! -d $dev_be_path ]
then
	echo Cannot find directory $TCMU_PATH/$dev_name
	exit 1
fi

echo Loopback device path is $dev_fe_path
echo TCMU device path is $dev_be_path

unlink $dev_fe_path
rmdir $lun0_path
rmdir $tpgt_path
rmdir $loopback_path

rmdir $dev_be_path

echo Disable TCMU done
