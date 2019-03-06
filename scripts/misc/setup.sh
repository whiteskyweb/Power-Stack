#!/usr/bin/env bash

NC='\033[0m' # No Color
GREEN_BG='\033[42m'
GREEN='\033[0;32m'

if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi