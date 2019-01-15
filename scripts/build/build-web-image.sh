#! /bin/bash

NC='\033[0m' # No Color
GREEN_BG='\033[42m'
GREEN='\033[0;32m'


cat << "EOF"
    ____                             _____ __             __      ____        _ __    __
   / __ \____ _      _____  _____   / ___// /_____ ______/ /__   / __ )__  __(_) /___/ /
  / /_/ / __ \ | /| / / _ \/ ___/   \__ \/ __/ __ `/ ___/ //_/  / __  / / / / / / __  /
 / ____/ /_/ / |/ |/ /  __/ /      ___/ / /_/ /_/ / /__/ ,<    / /_/ / /_/ / / / /_/ /
/_/    \____/|__/|__/\___/_/      /____/\__/\__,_/\___/_/|_|  /_____/\__,_/_/_/\__,_/    version 0.0.1


EOF


if hash docker 2>/dev/null; then
  cd ../../


  printf "${GREEN_BG}Building image${NC}\n"

    set -x

    docker build -t registry.gitlab.com/travel-nation/power-stack/web:v0.0.2  -f ./configs/docker/web/Dockerfile .

    set +x

  printf "${GREEN}done${NC}\n"

  printf "${GREEN_BG}Pushing image to registry${NC}\n"

    set -x
      docker push registry.gitlab.com/travel-nation/power-stack/web:v0.0.2
    set +x
  printf "${GREEN}done${NC}\n"

else
  echo >&2 "I require docker but it's not installed.  Aborting.";
fi