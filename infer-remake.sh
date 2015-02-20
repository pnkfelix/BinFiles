#!/bin/bash

DIR="."

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
done

echo "$CMD $@"
echo "$MSG"
echo
eval "$CMD" "$@"
