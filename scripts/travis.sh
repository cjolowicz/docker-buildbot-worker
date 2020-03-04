#!/bin/bash

# Determine branch from TRAVIS_TAG and TRAVIS_BRANCH.
#
# When a tag is built (TRAVIS_TAG), the branch cannot be determined from
# TRAVIS_BRANCH. Assume that it is a release tag: If the version is 1.8.x, we're
# on the 1.8 maintenance branch. Otherwise, we're on master.
#
# For PR builds (TRAVIS_PULL_REQUEST_BRANCH), use the branch from which the PR
# originated, not the target branch. This means that the same image is used for
# the Docker build cache as for the corresponding branch build.
if [ -n "$TRAVIS_PULL_REQUEST_BRANCH" ]
then
    BRANCH="$TRAVIS_PULL_REQUEST_BRANCH"
elif [ -z "$TRAVIS_TAG" ]
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
