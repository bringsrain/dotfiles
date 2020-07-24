#!/usr/bin/env bash
# Lets create some volume control
# using pactl, cuz my system
# use pulseaudio
# Notes:
# Volume Down Button XF86AudioLowerVolume
# Volume Up Button XF86AudioRaiseVolume
# Mute XF86AudioMute
# to use pulseaudio default devices as arguments
# sink == @DEFAULT_SINK@
# source == @DEFAULT_SOURCE@
# monitor == @DEAFULT_MONITOR@
# HOW pactl works
# Alsa devices -> pulseaudio daemon -> pactl

# Lest start with something simple
# Raise & lover volume by 1% make sure that mute toggle is off
# and then set toggle for mute
# Set variables for default value

STEP=1

if [[ -n "$1" ]]; then
  case "$1" in
    up)
      pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ +$STEP%
      ;;
    down)
      pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ -$STEP%
      ;;
    toggle)
      pactl set-sink-mute @DEFAULT_SINK@ toggle
      ;;
    *)
      echo "Invalid argument"
      exit 22
      ;;
  esac
else
  echo "No Argument"
  exit 22
fi

exit 0
