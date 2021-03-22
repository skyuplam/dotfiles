#!/bin/bash

input=$(slurp -o -f "%o")
/usr/lib/xdg-desktop-portal -r & /usr/lib/xdg-desktop-portal-wlr -r -o "$input" &
