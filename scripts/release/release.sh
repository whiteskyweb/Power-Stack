#! /bin/bash

release_images () {
  printf "${GREEN_BG}Pushing image to registry${NC}\n"

    set -x

      docker login -u gitlab-ci-token -p $CI_JOB_TOKEN
      docker push $REGISTRY/$1/$2:v$3

    set +x

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

