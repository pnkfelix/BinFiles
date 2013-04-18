#!/bin/sh

ME=$(basename $0)
RUST_DIR=rust-dbg-nopt
exec ~/opt/$RUST_DIR/bin/$ME "$@"
