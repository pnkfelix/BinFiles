set -e

function check {
    dir=$1
    echo $dir
    pushd ~/$dir > /dev/null
    set +e; test -z "$(git status --porcelain)"; ec=$? ; eval ${2}=$ec; set -e
    if test "$ec" = 1; then
        pwd
        git status
    fi
    popd
}

check "BinFiles" "bec"
echo "bec: " $bec

check "DotFiles" "dec"
echo "dec: " $dec

check "ConfigFiles" "cec"
echo "cec: " $cec

if test "$bec" = 1 -o "$dec" = 1 -o "$cec" = 1; then
    echo "At least one fsk directory is unclean."
    exit
fi

# if test "$bec" = 
