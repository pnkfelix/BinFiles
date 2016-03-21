#!/bin/bash

lspci | grep -i vmware > /dev/null
under_vmware=$?
# echo under_vmware: $under_vmware
if [ $under_vmware == "0" ]; then
    # echo Running under VMware
else
    # echo Not running under VMware
    setxkbmap -option ctrl:swapcaps
fi
