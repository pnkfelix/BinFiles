#!/bin/sh

ME=$(basename $0)
ANDROID_SDK_TOOLS_DIR=$HOME/Dev/Android/adt-bundle-mac-x86_64-20131030/sdk/tools

exec $ANDROID_SDK_TOOLS_DIR/$ME "$@"
