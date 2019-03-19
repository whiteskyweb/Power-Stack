#! /bin/bash

. ./scripts/build/setup.sh

build_image () {

  printf "${GREEN_BG}Building ${2} image${NC}\n"

    docker login -u $CI_DEPLOY_USER -p $CI_DEPLOY_PASSWORD $CI_REGISTRY
    echo $CI_DEPLOY_USER $CI_DEPLOY_PASSWORD $CI_REGISTRY
    docker build -t "${CI_REGISTRY}/${1}/${2}:dev"  -f "./infrastructure/docker/${1}-${2}/Dockerfile" .
    docker push "${CI_REGISTRY}/${1}/${2}:dev"

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