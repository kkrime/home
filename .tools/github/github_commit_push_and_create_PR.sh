#!/bin/bash

git commit -m "$1" && ~/tools/github_push_and_create_PR.sh $2
