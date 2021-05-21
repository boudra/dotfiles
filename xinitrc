#!/bin/bash

setxkbmap -option caps:ctrl_modifier

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --output DP-0 --left-of DP-1-1

xset r rate 200 25

exec i3
