#!/bin/sh
ME=$(basename $0)

#PYTHONDIR=/usr/local/bin
PYTHONDIR=/usr/bin
exec "$PYTHONDIR/$ME" "$@"
