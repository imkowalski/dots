#!/usr/bin/env bash
# Open the help file in a dedicated kitty window
kitty --class bspwm_help --name bspwm_help sh -c "cat /home/michal/bspwm_help.md; echo; echo 'Press ENTER to close...'; read"
