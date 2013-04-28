#!/bin/sh

ME=$(basename $0)
#RUSTDIR=rust
#RUSTDIR=rust-dbg-nopt
RUSTDIR=rust-nopt
exec ~/opt/$RUSTDIR/bin/$ME "$@"
