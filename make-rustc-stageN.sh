#!/bin/sh
ARCH=x86_64-apple-darwin
STAGE=$1

DIR=$(basename $(pwd))
echo "DIR: $DIR"

set -e

. ~/ConfigFiles/Bash/search_for_repo.sh

ROOT=.
if ! search_parents_for_dotgit ; then
    ROOT=$(dirname $last_git_path);
else
    echo "search failed";
    exit 244;
fi
echo "ROOT: $ROOT"


STAGE_DIR=$ARCH/$STAGE

SYNTAX_LIB=$STAGE_DIR/lib/stamp.syntax
RUSTC_LIB=$STAGE_DIR/lib/stamp.rustc
RUSTC_BIN=$STAGE_DIR/bin/rustc

if [ "$1" == "--no-libs" ] ; then
    OBJ_LIBS_TARGET=""
    END_MSG="Done; you can run $RUSTC_BIN on source code with #![no_std]"
else
    # OBJ_LIBS_TARGET="$SYNTAX_LIB $RUSTC_LIB rustc-$STAGE "
    OBJ_LIBS_TARGET="$RUSTC_LIB rustc-$STAGE "
    END_MSG="Done; you can run $RUSTC_BIN on source code using libstd crate"
fi


CMD="remake --trace $RUSTC_BIN $OBJ_LIBS_TARGET "
echo $CMD
$CMD

echo $END_MSG
