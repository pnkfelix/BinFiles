#!/bin/bash

DIR="$(pwd)"

while true; do
    if [ -e "$DIR/Cargo.toml" ]; then
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
