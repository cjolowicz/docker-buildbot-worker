#!/bin/bash

# Determine branch from TRAVIS_TAG and TRAVIS_BRANCH.
if [ -z "$TRAVIS_TAG" ]
then
    BRANCH="$TRAVIS_BRANCH"
elif [[ "$TRAVIS_TAG" =~ ^v1\.8\. ]]
then
    BRANCH=1.8
else
    BRANCH=master
fi

if [ -n "$TRAVIS_TAG" ]
then
    make push BRANCH=$BRANCH
else
    make push BRANCH=$BRANCH VERSION=$BRANCH
fi > make.log

status=$?

if [ $status -ne 0 ]
then
    echo "========================================================================"
    echo Job exited with status $status. Log follows:
    echo "========================================================================"
    tail --lines=4K make.log
fi

exit $status
