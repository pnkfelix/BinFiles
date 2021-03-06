#!/bin/bash

DIR="$(pwd)"

. $HOME/ConfigFiles/Bash/search_for_repo.sh

git log -1 --no-color
echo

# CFG_SRC_DIR=$(grep -s 'CFG_SRC_DIR ' config.mk | awk '{print $3}')
! search_parents_for_dotgit
echo last_git_path $last_git_path
CFG_SRC_DIR=$(dirname $last_git_path)
X_PY="${CFG_SRC_DIR}/x.py"

# X_PY_TESTS="src/test/{mir-opt,compile-fail,run-pass}"
# X_PY_TESTS="src/test/{incremental,ui,compile-fail,run-pass,mir-opt}"
X_PY_TESTS="src/test/{incremental,ui,compile-fail,codegen-units,mir-opt}"

ONLY_BUILD=0
DO_DIST=0
NO_TIDY=0
CLEAN_FIRST=0
NO_TESTS=0
VERBOSITY=""
JOBS=""
TARGET=""

STAGE="--stage 1 "

for arg in "$@"
do
    if [ "x$arg" = "xnotidy" ] ; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        NO_TIDY=1
    elif [ "x$arg" = "xverbose" ]; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        VERBOSE=-vv
    elif [ "x$arg" = "xone_job" ]; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        JOBS=-j1
    elif [ "x$arg" = "xclean" ]; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        echo "Sleeping for 5 seconds before initiating clean."
        sleep 5
        CLEAN_FIRST=1
    elif [ "x$arg" = "xbuild" ]; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        ONLY_BUILD=1
    elif [ "x$arg" = "xdist" ]; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        DO_DIST=1
    elif [ "x$arg" = "xstage1" ] ; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        STAGE="--stage 1 "
    elif [ "x$arg" = "xstage2" ] ; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        STAGE="--stage 2 "
        X_PY_TESTS="src/test/{compile-fail,ui,ui-fulldeps,run-fail,mir-opt,codegen,codegen-units,incremental}"
    elif [ "x$arg" = "xnotest" ] || [ "x$arg" = "xnotests" ] ; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        NO_TESTS=1
    elif [ "x$arg" = "xthumbv7em-none-eabi" ] ; then
        shift
        echo "Shifting \`$arg\` off args list; left with [$@]"
        TARGET="$arg"
    else
        # X_PY_FLAGS="--stage 1 --incremental "
        # X_PY_FLAGS="--keep-stage 1 --stage 1 "
        X_PY_FLAGS="--keep-stage 1 "
        # X_PY_FLAGS=" --stage 1 "
    fi
done

while true; do
    if [ -e "$DIR/config.toml" -a -e "$X_PY" ]; then
        echo X_PY=$X_PY

        if [ $CLEAN_FIRST == 1 ]; then
            echo "Cleaning"
            eval "$X_PY clean"
        fi

        TIDY=" time python $X_PY test  --stage 1 src/tools/tidy"
        if [ $NO_TIDY == 1 ]; then
            TIDY="true"
        fi
        # BUILD="time RUSTC_FLAGS=-Ztreat-err-as-bug python $X_PY build $VERBOSE $JOBS $STAGE $X_PY_FLAGS --target $TARGET src/libstd"
        if [ "x$TARGET" = "x" ]; then
            BUILD="time python $X_PY build $VERBOSE $JOBS $STAGE $X_PY_FLAGS "
        else
            BUILD="time python $X_PY build $VERBOSE $JOBS $STAGE $X_PY_FLAGS --target $TARGET "
        fi
        CHECK="time python $X_PY check $STAGE $X_PY_FLAGS "
        DIST="time python $X_PY dist  $STAGE $X_PY_FLAGS "
        TESTS="time python $X_PY test  $STAGE $X_PY_FLAGS $X_PY_TESTS"
        if [ $NO_TESTS == 1 ]; then
            TESTS="true"
        fi

        if [ "x$ONLY_BUILD" = "x1" ]; then
            CMD="$TIDY && $BUILD "
        elif [ "x$DO_DIST" = "x1" ]; then
            # CMD="$TIDY && $BUILD && $CHECK && $TESTS"
            CMD="$TIDY && $BUILD && $DIST && $TESTS"
        else
            # CMD="$TIDY && $BUILD && $CHECK && $TESTS"
            CMD="$TIDY && $BUILD && $TESTS"
        fi

        MSG='(flags of interest include `--stage 1` and `--help`)'
        break;
    elif [ -e "$DIR/Cargo.toml" ]; then
        CMD="cd $DIR && cargo build && cargo test"
        MSG='(flags of interest include `--verbose` and `-- --nocapture`)'
        break;
    elif [ -e "$DIR/Makefile" ]; then
        CMD="time remake -C $DIR -j1"
        MSG='(flags of interest include `--trace`)'
        break;
    fi
    "Did not find build config files in $DIR; going up to parent dir."
    DIR=$(realpath "$DIR/..")
done

echo "$CMD $@"
echo "$MSG"
echo
eval "$CMD" "$@"
