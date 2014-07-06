SIG=$1
echo "$SIG" | g++ -x c++ -S - -o- | grep "^_.*:$" | sed -e 's/:$//'
