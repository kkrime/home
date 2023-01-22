#!/bin/bash

if [ -z "$1" ]
then
    git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) && gh pr create --title "$(git log --pretty=format:%s -1 | sd '^.* (\w+\(.*\w\): .*)$' '$1')" --web 
    exit 0
fi
git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD) && gh pr create --title "$(git log --pretty=format:%s -1 | sd '^.* (\w+\(.*\w\): .*)$' '$1')" --web --base $1
