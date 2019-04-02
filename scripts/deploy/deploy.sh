#! /bin/bash

. ./scripts/deploy/setup.sh

cd ./infrastructure/kubernetes
helm dep build
export API_VERSION="$(grep "version" Chart.yaml | cut -d" " -f2)"
export RELEASE_NAME="libr-files-v${API_VERSION/./-}"
export DEPLOYS=$(helm ls | grep $RELEASE_NAME | wc -l)

if [ ${DEPLOYS}  -eq 0 ]; then helm install --name=${RELEASE_NAME} . --namespace=${STAGING_NAMESPACE}; else helm upgrade ${RELEASE_NAME} . --namespace=${STAGING_NAMESPACE}; fi