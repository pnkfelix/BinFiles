#!/bin/sh

# Hack to not rebuild the compiler itself: touch all of the stamp
# files in stage0.
find x86_64-apple-darwin/stage0/lib/rustlib/x86_64-apple-darwin/lib/ -name 'stamp.*' -print -exec touch {} \;

make rustc-stage1
