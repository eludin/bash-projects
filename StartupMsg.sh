#!/bin/zsh
# Created by Eludin
# Last Update: Feb 12 2026

logday=$(date +%A)
logtime=$(date +%-I:%M%p)

GREEN='\033[0;32m'
RESET='\033[0m'

echo -e "Hello ${GREEN}$(whoami)${RESET}! It is currently $logtime on $logday."
