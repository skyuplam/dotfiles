#!/usr/bin/env zsh

pgrep settimed | xargs kill 2>/dev/null

settimed -s -m scale ~/.config/sway/mojave-timed.stw &
