#! /bin/bash

. ./scripts/build/setup.sh

build_image () {
  printf "${GREEN_BG}Building ${2} image${NC}\n"

    echo "$CI_JOB_TOKEN" | docker login -u gitlab-ci-token --password-stdin

    docker build -t "${CI_REGISTRY}/${1}/${2}:dev"  -f "./infrastructure/docker/${1}-${2}/Dockerfile" .

    docker push "${REGISTRY}/${1}/${2}:dev"

  printf "${GREEN}done${NC}\n"
}


if hash docker 2>/dev/null; then

  build_image 'backend' 'php'
  build_image 'backend' 'web'
  build_image 'frontend' 'web'

else
  echo >&2 "I require docker but it's not installed.  Aborting.";
  exit 1;
fi