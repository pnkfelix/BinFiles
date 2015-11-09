#!/bin/bash

PORTS="61017 61027 61117 61127 61217 61227"
HOST=$(hostname)
for p in $PORTS; do
    echo $HOST $p
    ssh -T people.mozilla.org "echo $p > $HOST.attempt_port"
    ssh -N -T -R 61017:localhost:22 people.mozilla.org
    ssh -T people.mozilla.org "rm -f $HOST.attempt_port"
    echo $HOST $p died
    sleep 30
done

# nohup ssh -fN -T -R 61017:localhost:22 people.mozilla.org

