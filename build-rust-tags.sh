#!/bin/bash

# Exuberant ctags, installed via homebrew on OS X
# CTAGS=/usr/local/bin/ctags
CTAGS=ctags

RUST_DIR=$HOME/Dev/Mozilla/rust.git

#CTAGS_ARGS="-e -a --extra=+qf"
# CTAGS_ARGS="-e -a --extra=+f"
# CTAGS_ARGS="-e -a --extra=+f --options=$RUST_DIR/src/etc/ctags.rust"
# CTAGS_ARGS="-e -a --options=$RUST_DIR/src/etc/ctags.rust"
# May want to investigate options like --c++-kinds=... (see --list-kinds=c++)
CTAGS_ARGS="-e -a --extra=+f"

if hg root >& /dev/null ; then
    ROOT=$(hg root)
else
    ROOT=$(git rev-parse --show-toplevel)
fi

# $CTAGS $CTAGS_ARGS -R --options=$RUST_DIR/src/etc/ctags.rust

echo "Indexing from $ROOT"
cd $ROOT
rm -f TAGS
find src \( -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -exec $CTAGS $CTAGS_ARGS {} \;
find src \( -name '*.rs' -o -name '*.rc' \) -exec $CTAGS --language-force=rust $CTAGS_ARGS {} \;
