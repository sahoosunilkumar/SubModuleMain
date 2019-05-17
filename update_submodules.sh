#!/bin/bash

#Set whatever number of arguments you expect for the Java jar you have
ARGS_EXPECTED=1

shouldPush=true

if [[ $# == ${ARGS_EXPECTED} ]]
then
currentBranch=`git rev-parse --abbrev-ref HEAD`
if [[ "$currentBranch" = "development" ]];
then
branchName='develop'
else
branchName="$currentBranch"
fi

for OUTPUT in $(grep path .gitmodules | sed 's/.*= //')
do
submoduleConfigUpdate="git config -f .gitmodules submodule.$OUTPUT.branch $branchName"
eval ${submoduleConfigUpdate}
done

submoduleUpdateCommand="git submodule update --remote --merge --recursive|| echo \"Error\""
updateResult=$(eval ${submoduleUpdateCommand})
if [[ ${updateResult} == *Error* ]]; then
  shouldPush=false
  echo ${updateResult}
  else
  shouldPush=true
fi

if [[ ("$1" = "-push") && (${shouldPush}=true) ]]
then
codePushCommand="git add --all && git commit -m 'bumping submodules' && git push origin $currentBranch"
eval ${codePushCommand}
echo "SUCCESS"
else
echo "Error"
fi
  exit 0
else
  echo "[$HOSTNAME]: Usage: `basename $0` -push to push the code"
  exit 1
fi

