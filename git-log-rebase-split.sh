#!/bin/sh

set -e

if [ ! $# -eq 2 ]; then
    echo 'Usage: $0 BASE_COMMIT SPLIT_COMMIT'
    exit 0
fi

BASE_COMMIT=$1
SPLIT_COMMIT=$2

echo generating: /tmp/rebase.patch /tmp/pre-rebase.patch
git log $SPLIT_COMMIT..HEAD --no-color --stat --patch > /tmp/rebase.patch
git log $BASE_COMMIT..$SPLIT_COMMIT --no-color --stat --patch > /tmp/pre-rebase.patch
