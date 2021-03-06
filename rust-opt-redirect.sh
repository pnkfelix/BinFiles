#!/bin/sh

ME=$(basename $0)
# ME=rustc

#RUST_DIR=rust
#RUST_DIR=rust-nopt
#RUST_DIR=rust-dbg-nopt
#RUST_DIR=rust-dbg
# RUST_DIR=releases/rust-0.12.0-x86_64-apple-darwin
RUST_DIR=multirust

CARGO_DIR=cargo

DIR=~/opt/$RUST_DIR
WHERE=$DIR/bin/$ME

if [ "$1" == "--where" ] ; then
    echo "$WHERE";
    exit;
fi

export DYLD_LIBRARY_PATH=$DIR/lib:$LD_LIBRARY_PATH

exec "$WHERE" "$@"
