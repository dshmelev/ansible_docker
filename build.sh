#!/bin/bash

render() {
sedStr="
  s!%%ANSIBLE_VERSION%%!$version!g;
"

sed -r "$sedStr" $1
}


mkdir -p .build/$ANSIBLE_VERSION
render Dockerfile.template > .build/$ANSIBLE_VERSION/Dockerfile
docker login -u $DOCKER_USER -p $DOCKER_PASS
docker build -t $DOCKER_REPO:$ANSIBLE_VERSION .build/$ANSIBLE_VERSION
docker push $DOCKER_REPO:$ANSIBLE_VERSION
docker logout
