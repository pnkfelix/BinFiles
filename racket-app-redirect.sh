#!/bin/sh

ME=$(basename $0)
# exec /Applications/Racket\ v5.3.6/bin/$ME $@
DIR=/Applications/Racket\ v5.93/bin
if [ -e "$DIR/$ME" ] ; then
    exec "$DIR/$ME" "$@"
fi
DIR=/Applications/Racket\ v5.3.2/bin
if [ -e "$DIR/$ME" ] ; then
    exec "$DIR/$ME" "$@"
fi
DIR=/Applications/Racket\ v5.3.6/bin
if [ -e "$DIR/$ME" ] ; then
    exec "$DIR/$ME" "$@"
fi

echo "Could not find Racket installation."
exit 1
