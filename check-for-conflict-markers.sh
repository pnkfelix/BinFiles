#!/bin/sh

# Adapted from https://jondowdle.com/2015/02/block-merge-conflicts-in-commits/
#
# At the original web site, this script *was* the file in
#
#   repo/.git/hooks/pre-commit
#
# So symlinking ths there is certainly one option for installation.
# (Another is probably sourcing this file from there.)

## pre-commit script to prevent merge markers from being committed. 
## Author: Jon Dowdle <jdowdle@gmail.com>

##
## This simply searches the files that you are about to commit.
##

changed=$(git diff --cached --name-only)

if [[ -z "$changed" ]]
then
    exit 0
fi

echo $changed | xargs egrep '[><]{7}' -H -I --line-number

## If the egrep command has any hits - echo a warning and exit with non-zero status.
if [ $? == 0 ]
then
    echo "\n\nWARNING: You have merge markers in the above files, lines. Fix them before committing.\n\n"
    exit 1    
fi

