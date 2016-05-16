#!/bin/sh

if (which gnome-terminal > /dev/null) ; then
    # echo hi;
    exec gnome-terminal -e ~/bin/bash-i3-reminder.sh
else
    # echo yo;
    exec urxvt -e ~/bin/bash-i3-reminder.sh
fi
