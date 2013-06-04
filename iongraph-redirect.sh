#!/bin/sh

ME=$(basename $0)
case $ME in
    *genpdfs)
        ME="genpdfs"
	;;
    *genpngs)
        ME="genpngs"
	;;
    *)
	;;
esac

IONGRAPH_DIR=~/Dev/Mozilla/iongraph.git
exec $IONGRAPH_DIR/$ME "$@"
