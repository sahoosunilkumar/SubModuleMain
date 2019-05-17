#!/bin/bash

#Set whatever number of arguments you expect for the Java jar you have
ARGS_EXPECTED=1

if [[ $# == ${ARGS_EXPECTED} ]]
then
currentBranch=`git rev-parse --abbrev-ref HEAD`
if [[ "$currentBranch" = "development" ]];
then
branchName='develop'
else
branchName="$currentBranch"
fi

echo "current branch : $branchName"

for OUTPUT in $(grep path .gitmodules | sed 's/.*= //')
do
echo "$OUTPUT"
submoduleConfigUpdate="git config -f .gitmodules submodule.$OUTPUT.branch $branchName"
eval ${submoduleConfigUpdate}
echo "submodule config : $submoduleConfigUpdate"
done

submoduleUpdateCommand="git submodule update --remote --merge --recursive"
eval ${submoduleUpdateCommand}
echo $1

if [[ "$1" = "-m" ]]
then
codePushCommand="git add --all && git commit -m 'bumping submodules' && git push origin $currentBranch"
eval ${codePushCommand}
fi
  exit 0
else
  echo "[$HOSTNAME]: Usage: `basename $0` filename arg1 arg2"
  exit 1
fi

