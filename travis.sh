#!/bin/bash

: ${VERSION:=${TRAVIS_TAG#v}}
: ${VERSION:=$TRAVIS_BRANCH}
: ${BRANCH:=${TRAVIS_TAG:+master}}
: ${BRANCH:=$TRAVIS_BRANCH}

make push VERSION=$VERSION BRANCH=$BRANCH > make.log

status=$?

if [ $status -ne 0 ]
then
    echo "========================================================================"
    echo Job exited with status $status. Log follows:
    echo "========================================================================"
    tail --lines=4K make.log
fi

exit $status
