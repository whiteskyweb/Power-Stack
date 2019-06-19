#!/bin/bash
. ./scripts/misc/globals.sh

printf "${GREEN}Updating backend packages${NC}\n"
cd backend-code
COMPOSER_PROCESS_TIMEOUT=2000 composer update --prefer-dist --no-dev

printf "${GREEN}Updating frontend packages${NC}\n"
cd ../frontend-code
npm update