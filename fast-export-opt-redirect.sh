#!/bin/sh

ME=$(basename $0)
case $ME in
    hg-fast-export)
        ME="hg-fast-export.sh"
	;;
    *)
	;;
esac
#DIR=~/Dev/Git/fast-export
DIR=~/opt/git-hg/lib/git-hg/fast-export
exec $DIR/$ME "$@"
