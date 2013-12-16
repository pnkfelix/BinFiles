#!/bin/sh

ME=$(basename $0)
RUST_DIR=rust
#RUST_DIR=rust-nopt
#RUST_DIR=rust-dbg-nopt
RUST_DIR=rust-dbg
exec ~/opt/$RUST_DIR/bin/$ME "$@"
