#!/bin/bash

DIR="$(pwd)"

. $HOME/ConfigFiles/Bash/search_for_repo.sh

# CFG_SRC_DIR=$(grep -s 'CFG_SRC_DIR ' config.mk | awk '{print $3}')
! search_parents_for_dotgit
echo last_git_path $last_git_path
CFG_SRC_DIR="$last_git_path/../"
X_PY="${CFG_SRC_DIR}x.py"

while true; do
    if [ -e "$DIR/config.toml" -a -e "$X_PY" ]; then
        echo X_PY=$X_PY
        # CMD="time python $X_PY test src/tools/tidy && time python $X_PY build --stage 1 --incremental --keep-stage 0 src/libstd && time python $X_PY test --stage 1 src/test/{mir-opt,compile-fail,run-pass}"
        CMD="pushd $DIR && time python $X_PY test src/tools/tidy && time python $X_PY build --stage 1 --incremental --verbose src/libstd && time python $X_PY test --stage 1 src/test/{mir-opt,compile-fail,run-pass} && popd"
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
