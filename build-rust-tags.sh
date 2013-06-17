#!/bin/bash

# Exuberant ctags, installed via homebrew on OS X
# CTAGS=/usr/local/bin/ctags
CTAGS=ctags

RUST_DIR=$HOME/Dev/Mozilla/rust.git

# CTAGS_ARGS="-e -a --extra=+f"
# CTAGS_ARGS="-e -a --extra=+f --options=$RUST_DIR/src/etc/ctags.rust"
CTAGS_ARGS="-e -a --options=$RUST_DIR/src/etc/ctags.rust"

if hg root >& /dev/null ; then
    ROOT=$(hg root)
else
    ROOT=$(git rev-parse --show-toplevel)
fi

echo "Indexing from $ROOT"
cd $ROOT
rm -f TAGS
find . \( -name '*.rs' -o -name '*.rc' \) -exec $CTAGS $CTAGS_ARGS {} \;

# $CTAGS $CTAGS_ARGS -R --options=$RUST_DIR/src/etc/ctags.rust
