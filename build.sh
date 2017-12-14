#!/bin/bash
set -e

render() {
  sedStr="s!%%ANSIBLE_VERSION%%!$ANSIBLE_VERSION!g;"
  sed -r "$sedStr" $1
}


mkdir -p .build/$ANSIBLE_VERSION
render Dockerfile.template > .build/$ANSIBLE_VERSION/Dockerfile
cp entrypoint.sh .build/$ANSIBLE_VERSION/entrypoint.sh

docker login -u $DOCKER_USER -p $DOCKER_PASS
docker build -t $DOCKER_REPO:$ANSIBLE_VERSION .build/$ANSIBLE_VERSION
docker push $DOCKER_REPO:$ANSIBLE_VERSION
docker logout
