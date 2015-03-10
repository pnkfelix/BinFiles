#!/bin/sh

ME=$(basename $0)
CARGO_DIR=cargo-dbg

DIR=~/opt/$CARGO_DIR
WHERE=$DIR/bin/$ME

if [ "$1" == "--where" ] ; then
    echo "$WHERE";
    exit;
fi

export DYLD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH

exec "$WHERE" "$@"
