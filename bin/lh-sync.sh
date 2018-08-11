#!/bin/bash

set -x
set -e

LONGHORN_DIR=~/develop/longhorn
LONGHORN_MGR_DIR=~/develop/go/src/github.com/rancher/longhorn-manager
LONGHORN_TEST_DIR=~/develop/longhorn-tests/manager/integration

rm -rf $LONGHORN_DIR/deploy/
mkdir $LONGHORN_DIR/deploy/

DEPLOY_YAML=${LONGHORN_DIR}/deploy/longhorn.yaml
files=`find $LONGHORN_MGR_DIR/deploy/ |grep yaml |sort`
for f in $files
do
	echo $f
	cat $f >> $DEPLOY_YAML
	echo --- >> $DEPLOY_YAML
done

cp -r $LONGHORN_TEST_DIR/deploy/backupstores $LONGHORN_DIR/deploy/

rm -rf $LONGHORN_DIR/examples/
mkdir $LONGHORN_DIR/examples/

cp -r $LONGHORN_MGR_DIR/examples $LONGHORN_DIR
