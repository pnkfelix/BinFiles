#!/bin/bash

HOST=$(hostname)
SLEEP_TIME=30

PORT=61017
ssh -T people.mozilla.org "echo $PORT > $HOST.attempt_port"
autossh -M 20000 -N people.mozilla.org -R $PORT:localhost:22 -C
ssh -T people.mozilla.org "rm -f $HOST.attempt_port"

# PORTS="61017 61027 61117 61127 61217 61227"

# for p in $PORTS; do
#     echo Attempting to reverse tunnel to $HOST via port $p
# 
#     ssh -T people.mozilla.org "echo $p > $HOST.attempt_port"
#     ssh -N -T -R $p:localhost:22 people.mozilla.org
#     ssh -T people.mozilla.org "rm -f $HOST.attempt_port"
# 
#     echo $HOST port $p died; sleeping for $SLEEP_TIME seconds
#     sleep $SLEEP_TIME
# done

# nohup ssh -fN -T -R 61017:localhost:22 people.mozilla.org

