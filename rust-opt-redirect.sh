#!/bin/sh

ME=$(basename $0)
RUST_DIR=rust
#RUST_DIR=rust-nopt
#RUST_DIR=rust-dbg-nopt
RUST_DIR=rust-dbg

WHERE=~/opt/$RUST_DIR/bin/$ME

if [ $1 == "--where" ] ; then
    echo "$WHERE";
    exit;
fi

exec "$WHERE" "$@"
