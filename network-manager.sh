#!/bin/bash

## This should already be enabled
# systemctl enable NetworkManager

systemctl start NetworkManager

echo Starting nm-applet; hopefully X is started

exec nm-applet
