#!/bin/sh

ME=$(basename $0)
RUST_DIR=rust
#RUST_DIR=rust-nopt
#RUST_DIR=rust-dbg-nopt
RUST_DIR=rust-dbg

DIR=~/opt/$RUST_DIR
WHERE=$DIR/bin/$ME

if [ "$1" == "--where" ] ; then
    echo "$WHERE";
    exit;
fi

export DYLD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH

exec "$WHERE" "$@"
