#!/bin/sh

ME=$(basename $0)
DIR=/usr/bin
# DIR=~/opt/llvm-dbg-nopt/bin
# DIR=~/opt/llvm/bin
# DIR=~/Dev/Mozilla/rust.git/objdir-dbg/x86_64-apple-darwin/llvm/Release+Asserts/bin/
exec "$DIR/$ME" "$@"
