#!/bin/sh

ME=$(basename $0)
# DIR=~/opt/llvm/bin
DIR=/usr/bin
# DIR=~/Dev/Mozilla/rust.git/objdir-dbg/x86_64-apple-darwin/llvm/Release+Asserts/bin/
# DIR=~/opt/llvm-dbg/bin

exec "$DIR/$ME" "$@"
