#!/bin/sh

ME=$(basename $0)
# CARGO_DIR=cargo-dbg
CARGO_DIR=multirust

# DIR=~/opt/$CARGO_DIR
# DIR=~/opt/multirust
DIR=~/.cargo

WHERE=$DIR/bin/$ME

if [ "$1" == "--where" ] ; then
    echo "$WHERE";
    exit;
fi

export DYLD_LIBRARY_PATH=$DIR/lib:$DYLD_LIBRARY_PATH
export LD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH

exec "$WHERE" "$@"
