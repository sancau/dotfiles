#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --mode 2560x1440 --pos 0x720 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --primary --mode 3840x2160 --pos 2560x0 --rotate normal
xset -b
nitrogen --restore
killall conky
