# DELLARCH=10.243.30.83
# DELLARCH=10.243.29.112
DELLARCH=10.243.28.27

ifconfig | grep "inet " | grep -v 127.0.0.1 | grep 10.243
VALUE=$?

if [ $VALUE == 0 ]; then
    echo "We are on Mozilla local net; directly connecting"

    ssh -A -t pnkfelix@$DELLARCH
else
    echo "We are outside Mozilla local net; connecting via ssh bridge"

    # ssh -A -t people.mozilla.org ssh localhost -p 61017
    ssh -A -t fklock@ssh.mozilla.com ssh pnkfelix@$DELLARCH

fi
