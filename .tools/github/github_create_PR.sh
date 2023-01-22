#!/bin/bash

if [ -z "$1" ]
then
    gh pr create --title "$(git log --pretty=format:%s -1 | sd '^.* (\w+\(.*\w\): .*)$' '$1')" --web 
    exit 0
fi
gh pr create --title "$(git log --pretty=format:%s -1 | sd '^.* (\w+\(.*\w\): .*)$' '$1')" --web --base $1
 # gh alias set --shell cpr 'git push origin HEAD && gh pr create --title "$(git log --pretty=format:%s -1)" --web --base'
