#!/bin/bash

kubectl delete -f ~/develop/longhorn-tests/manager/integration/deploy/test.yaml

set -e
kubectl create -f ~/develop/longhorn-tests/manager/integration/deploy/test.yaml
sleep 10
kubectl logs longhorn-test
