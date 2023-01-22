#!/bin/bash

if [ -z "$1" ]
then
    echo >&2 echo "No commit messag supplied"
    exit 0
fi

git commit -m "$1" && git push --set-upstream origin
