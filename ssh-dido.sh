#!/bin/sh

if [ $# -eq 0 ]; then
    ssh -p 39901 pnkfelix@fklock-Dido-arch.local
elif [ $# -eq 1 ]; then
    ssh -p 39901 pnkfelix@$1
else
    echo "$0 takes 0 or 1 arguments."
    exit 2
fi

