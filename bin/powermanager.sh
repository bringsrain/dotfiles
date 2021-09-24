#!/usr/bin/env bash

## start xfce4-power-manager
if [[ -n "$1" ]]; then
  case "$1" in
    start)
      xfce4-power-manager
      ;;
    restart)
      xfce4-power-manager --restart
      ;;
    stop)
      xfce4-power-manager -q
      ;;
    *)
      echo "invalid argument"
      exit 1
      ;;
  esac
fi
exit 0
