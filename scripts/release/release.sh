#! /bin/bash

. ./scripts/release/setup.sh

release_images () {

  printf "${GREEN_BG}Pushing image to registry${NC}\n"

    docker tag "${CI_REGISTRY}/${1}/${2}:dev" "${CI_REGISTRY}/${1}/${2}:${3}"
    docker tag "${CI_REGISTRY}/${1}/${2}:${3}" "${CI_REGISTRY}/${1}/${2}:latest"

  printf "${GREEN}done${NC}\n"

}


if hash docker 2>/dev/null; then

  release_images 'backend' 'php' $VERSION
  release_images 'backend' 'web' $VERSION
  release_images 'frontend' 'web' $VERSION

else

  echo >&2 "I require docker but it's not installed.  Aborting.";
  exit 1;

fi

