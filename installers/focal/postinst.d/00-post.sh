#!/bin/bash

chmod -R +x /usr/share/ratflow/scripts/*
chmod +x /usr/bin/ratflow-session
chmod +x /usr/bin/rfreload

# enable icons in kde applications
envFile=/etc/environment
themeString='QT_QPA_PLATFORMTHEME=qt5ct'

if ! grep -q "$themeString" $envFile
then
    echo "$themeString" >> $envFile
fi
