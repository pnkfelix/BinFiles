if [ -e Makefile ]
then
    if ( echo $(pwd) | grep rust > /dev/null );
    then
        CMD="time remake -j1"
    else
        CMD="time remake -j8"
    fi
elif [ -e Cargo.toml ]
then
    CMD="time cargo test -- --nocapture"
fi

echo "$CMD"
$CMD
