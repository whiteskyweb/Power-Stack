#! /bin/bash

. ./scripts/misc/setup.sh

cat << "EOF"
    ____                             _____ __             __      ____        _ __    __
   / __ \____ _      _____  _____   / ___// /_____ ______/ /__   / __ )__  __(_) /___/ /
  / /_/ / __ \ | /| / / _ \/ ___/   \__ \/ __/ __ `/ ___/ //_/  / __  / / / / / / __  /
 / ____/ /_/ / |/ |/ /  __/ /      ___/ / /_/ /_/ / /__/ ,<    / /_/ / /_/ / / / /_/ /
/_/    \____/|__/|__/\___/_/      /____/\__/\__,_/\___/_/|_|  /_____/\__,_/_/_/\__,_/    version 0.0.1


EOF

build_image () {
  printf "${GREEN_BG}Building ${2} image${NC}\n"

    set -x
      docker build -t $REGISTRY/$1/$2:v$3  -f ./infrastructure/docker/$1-$2/Dockerfile .
    set +x

  printf "${GREEN}done${NC}\n"

  printf "${GREEN_BG}Pushing image to registry${NC}\n"

    set -x
      docker push $REGISTRY/$1/$2:v$3
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