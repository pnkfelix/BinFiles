#!/bin/bash

# Exuberant ctags, installed via homebrew on OS X
CTAGS=/usr/local/bin/ctags
#CTAGS_ARGS="-e -a --extra=+qf"
CTAGS_ARGS="-e -a --extra=+f"
# May want to investigate options like --c++-kinds=... (see --list-kinds=c++)

if hg root >& /dev/null ; then
    ROOT=$(hg root)
else
    ROOT=$(git rev-parse --show-toplevel)
fi

echo "Indexing from $ROOT"
cd $ROOT
rm -f TAGS
find js/src \( -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -exec $CTAGS $CTAGS_ARGS {} \;
find js/public \( -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -exec $CTAGS $CTAGS_ARGS {} \;
find js/ductwork \( -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -exec $CTAGS $CTAGS_ARGS {} \;
find nsprpub \( -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -exec $CTAGS $CTAGS_ARGS {} \;
find mfbt \( -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) -exec $CTAGS $CTAGS_ARGS {} \;
