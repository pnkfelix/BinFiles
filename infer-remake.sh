if ( echo $(pwd) | grep rust > /dev/null ); then
    CMD="time remake -j1"
else
    CMD="time remake -j8"
fi


echo "$CMD"
$CMD
