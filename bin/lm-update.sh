#!/bin/bash

#set -x
set -e

update=$1

base="/home/yasker/develop/go/src/github.com/rancher/longhorn-manager"
yaml=${base}"/deploy/02-components/01-manager.yaml"
driver_yaml=${base}"/deploy/02-components/04-driver.yaml"
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
sed -i "s/image\:\ .*\/${project}:.*/image\:\ ${escaped_private}/g" $driver_yaml
sed -i "s/-\ .*\/${project}:.*/-\ ${escaped_private}/g" $driver_yaml

set +e

if [ "$update" == ""  ]
then
	kubectl delete -f $yaml
	kubectl create -f $yaml
	kubectl delete -f $driver_yaml
	kubectl create -f $driver_yaml
fi
