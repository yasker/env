#!/bin/bash

#set -x
set -e

base="/home/yasker/develop/go/src/github.com/rancher/longhorn-manager"
yaml=${base}"/deploy/02-components/01-manager.yaml"
project="longhorn-manager"

latest=`cat ${base}/bin/latest_image`
private=`sed "s/rancher/yasker/g" ${base}/bin/latest_image`

echo latest image ${latest}
echo latest private image ${private}
docker tag ${latest} ${private}
docker push ${private}

escaped_private=${private//\//\\\/}
sed -i "s/image\:\ .*\/${project}:.*/image\:\ ${escaped_private}/g" $yaml
sed -i "s/-\ .*\/${project}:.*/-\ ${escaped_private}/g" $yaml

kubectl delete -f $yaml
kubectl create -f $yaml
