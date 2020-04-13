#!/bin/bash

Xvfb $DISPLAY -screen 0 1280x800x24 &
x11vnc -forever &
su -c "ratflow-session" rfuser &
bash
