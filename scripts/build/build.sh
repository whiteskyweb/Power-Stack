#! /bin/bash

build_image () {
  printf "${GREEN_BG}Building ${2} image${NC}\n"

    set -x

      docker build -t $CI_REGISTRY/$1/$2:v$3  -f ./infrastructure/docker/$1-$2/Dockerfile .

    set +x

  printf "${GREEN}done${NC}\n"
}


if hash docker 2>/dev/null; then

  build_image 'backend' 'php' $VERSION
  build_image 'backend' 'web' $VERSION
  build_image 'frontend' 'web' $VERSION

else
  echo >&2 "I require docker but it's not installed.  Aborting.";
  exit 1;
fi