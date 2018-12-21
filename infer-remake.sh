#!/bin/bash

DIR="$(pwd)"

. $HOME/ConfigFiles/Bash/search_for_repo.sh

# CFG_SRC_DIR=$(grep -s 'CFG_SRC_DIR ' config.mk | awk '{print $3}')
! search_parents_for_dotgit
echo last_git_path $last_git_path
CFG_SRC_DIR="$last_git_path/../"
X_PY="${CFG_SRC_DIR}x.py"

# X_PY_TESTS="src/test/{mir-opt,compile-fail,run-pass}"
X_PY_TESTS="src/test/{ui,compile-fail,run-pass,mir-opt}"

ONLY_BUILD=0

arg=$1
if [ "x$arg" = "xbuild" ]; then
    shift
    echo "Shifting \`$arg\` off args list; left with [$@]"
    ONLY_BUILD=1
elif [ "x$arg" = "xstage1" ] ; then
    shift
    echo "Shifting \`$arg\` off args list; left with [$@]"
    X_PY_FLAGS="--stage 1 "
elif [ "x$arg" = "xstage2" ] ; then
    shift
    echo "Shifting \`$arg\` off args list; left with [$@]"
    X_PY_FLAGS="--stage 2 "
    X_PY_TESTS="src/test/{compile-{fail,fail-fulldeps},ui,ui-fulldeps,run-{pass,fail,pass-fulldeps,fail-fulldeps},mir-opt,codegen,codegen-units,incremental,incremental-fulldeps}"
else
    # X_PY_FLAGS="--stage 1 --incremental "
    # X_PY_FLAGS="--keep-stage 1 --stage 1 "
    X_PY_FLAGS="--keep-stage 1 --stage 1 "
    # X_PY_FLAGS=" --stage 1 "
fi


while true; do
    if [ -e "$DIR/config.toml" -a -e "$X_PY" ]; then
        echo X_PY=$X_PY

        TIDY=" time python $X_PY test  --stage 1 src/tools/tidy"
        BUILD="time RUSTC_FLAGS=-Ztreat-err-as-bug python $X_PY build $X_PY_FLAGS src/libstd"
        CHECK="time python $X_PY check $X_PY_FLAGS "
        TESTS="time python $X_PY test  $X_PY_FLAGS $X_PY_TESTS"

        if [ "x$ONLY_BUILD" = "x1" ]; then
            CMD="$TIDY && $BUILD "
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
