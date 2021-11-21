#!/bin/bash

while getopts "c:" arg; do
  case $arg in
    c) COMMIT_MESSAGE=$OPTARG ;;
  esac
done

shift $((OPTIND-1))

if [ -z $COMMIT_MESSAGE ]; then
  echo 'Commit message will set default'
  COMMIT_MESSAGE="Modify kururu-blog [at `date '+%d/%m/%Y %H:%M'`]"
fi

if [ ! $(git branch --show-current) == "main" ]; then
  echo 'Current branch is not main'
  echo 'Please switch branch to main..'
  exit 1
fi

# (Re)create public folder by hugo
hugo

# Staging all changed file
git add .

# Commit
# Default message [Modify kururu-blog ]
git commit -m "$COMMIT_MESSAGE"

# Push main
git push origin main
