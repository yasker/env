#!/bin/bash

#set -x
set -e

base="/home/yasker/develop/longhorn-tests/manager/integration"
yaml=${base}"/deploy/test.yaml"
project="longhorn-manager-test"

latest=`cat ${base}/bin/latest_image`
private=`sed "s/rancher/yasker/g" ${base}/bin/latest_image`

echo latest image ${latest}
echo latest private image ${private}
docker tag ${latest} ${private}
docker push ${private}

escaped_private=${private//\//\\\/}
sed -i "s/image\:\ .*\/${project}:.*/image\:\ ${escaped_private}/g" $yaml

set +e

kubectl delete -f $yaml
kubectl create -f $yaml
