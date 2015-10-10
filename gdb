#!/bin/sh
ME=$(basename $0)

GDBDIR=~/opt/gdb-nopt
# GDBBIN=$GDBDIR/bin/gdb
GDBBIN=/usr/bin/gdb
if [ -e $GDBBIN ] ; then
    #    echo "Its there"
    true
else
    GDBBIN=/usr/bin/gdb
    echo "Not there; switching to $GDBBIN"
fi

exec $GDBBIN "$@"
