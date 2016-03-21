#!/bin/sh

ME=$(basename $0)
ANDROID_PLATFORM_TOOLS_DIR=$HOME/Dev/Android/adt-bundle-mac-x86_64-20131030/sdk/platform-tools

exec $ANDROID_PLATFORM_TOOLS_DIR/$ME "$@"
