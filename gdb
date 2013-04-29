#!/bin/sh
ME=$(basename $0)

GDBDIR=~/opt/gdb-nopt
GDBBIN=$GDBDIR/bin/gdb
#GDBBIN=/usr/bin/gdb
if [ -e $GDBBIN ] ; then
    echo "Its there"
else
    echo "Not there"
fi

exec $GDBBIN "$@"
