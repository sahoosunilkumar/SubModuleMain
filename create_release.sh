#!/usr/bin/env bash

#!/bin/bash

#Set whatever number of arguments you expect for the Java jar you have
ARGS_EXPECTED=1

if [[ $# == ${ARGS_EXPECTED} ]]
then


pwd="pwd"
rootDirectory=$(eval ${pwd})

for OUTPUT in $(grep path .gitmodules | sed 's/.*= //')
do

branchExistCommand="cd $OUTPUT && git ls-remote --heads origin $1"
branchDetail=$(eval ${branchExistCommand})
echo "${#branchDetail}"

if [[ "${#branchDetail}" <= 0 ]]; then
echo "CREATING BRANCH $1"
#createBranchCommand="git checkout -b $1 && git push origin $1"
#eval ${createBranchCommand}
fi
rootDirectoryCommand="cd $rootDirectory"
eval ${rootDirectoryCommand}
done

eval ${createBranchCommand}
else
  echo "[$HOSTNAME]: Usage: `basename $0` branchname"
  exit 1
fi

