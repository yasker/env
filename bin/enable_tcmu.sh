#!/bin/bash

#set -x
set -e

if [ -z $1 ]
then
	echo Device file name required
	exit 1
fi

if [ -z $2 ]
then
	echo Device file size required
	exit 1
fi

dev_name=$1
dev_size=$2

if [ ! -e /root/$dev_name ]
then
	echo cannot find /root/$dev_name
	exit 1
fi

#dev_size=160755712
#dev_size=1024000000
#dev_size=68719476736
block_size=4096
dev_config=file//root/$dev_name
tcmu_user=user_1

loopback_uuid=`uuid -v 4`
loopback_wwn="naa.6001405"${loopback_uuid:0:8}
nexus_uuid=`uuid -v 4`
nexus_wwn="naa.6001405"${nexus_uuid:0:8}

TCM_PATH=/sys/kernel/config/target

mkdir -p $TCM_PATH/core/$tcmu_user/$dev_name
echo dev_size=$dev_size > $TCM_PATH/core/$tcmu_user/$dev_name/control
echo dev_config=$dev_config > $TCM_PATH/core/$tcmu_user/$dev_name/control
echo hw_block_size=$block_size > $TCM_PATH/core/$tcmu_user/$dev_name/control
#echo async=1 > $TCM_PATH/core/$tcmu_user/$dev_name/control
echo 1 > $TCM_PATH/core/$tcmu_user/$dev_name/enable

mkdir -p $TCM_PATH/loopback/$loopback_wwn/tpgt_1
echo $nexus_wwn > $TCM_PATH/loopback/$loopback_wwn/tpgt_1/nexus
mkdir -p $TCM_PATH/loopback/$loopback_wwn/tpgt_1/lun/lun_0
ln -s $TCM_PATH/core/$tcmu_user/$dev_name/ $TCM_PATH/loopback/$loopback_wwn/tpgt_1/lun/lun_0/

echo $loopback_wwn
