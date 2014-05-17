set -e
set -x

SRC=$1
TGT=$2

function main() {
    do_clone
    setup_objdirs
    setup_remotes
}

function do_clone() {
    git clone $SRC $TGT
    for d in gyp libuv llvm ; do
        git clone $SRC/src/$d $TGT/src/$d
    done
}

function setup_objdirs() {
    for objdir in objdir-dbgopt objdir-opt ; do
        mkdir $TGT/$objdir
        if [ -e $SRC/$objdir/dl ] ; then
            cp -a $SRC/$objdir/dl $TGT/$objdir
        fi
    done
}

function setup_remotes() {
    # http://blog.edwards-research.com/2010/01/quick-bash-trick-looping-through-output-lines/

    # One could save the old IFS and set/restore it as appropriate on
    # entry/repeat/end of the loop, as described in the post above.
    #
    ## OIFS="${IFS}"
    ## NIFS=$'\n'
    ## IFS="${NIFS}"
    #
    # Or one can just set IFS in a subshell, as below.

    (
        IFS=$'\n'

        REMOTES=$( cd $SRC ; git remote -v | grep fetch | cut -d ' ' -f 1)
        for n in $REMOTES ; do 
            R_NAME=$(echo $n | cut -f 1)
            R_PATH=$(echo $n | cut -f 2)
            ( cd $TGT ; git remote add $R_NAME $R_PATH )
        done
    )
}

main
