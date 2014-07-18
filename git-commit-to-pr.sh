#!/bin/sh

# CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
if [ ! $# -eq 1 ]; then
    echo 'Usage: $0 COMMIT'
    exit 0
fi

git log $CURRENT_BRANCH ^$1 --ancestry-path --oneline --merges | \
    tail -1 | \
    sed 's@.*#\([0-9]*\) : .*@http://github.com/mozilla/rust/pull/\1@'
