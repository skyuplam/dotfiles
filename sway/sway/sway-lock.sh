#!/bin/bash
 
# Dependencies:
# imagemagick
# swaylock
# grim
# corrupter (https://github.com/r00tman/corrupter)
 
IMAGE=/tmp/i3lock.png
LOCKARGS=""

for OUTPUT in `swaymsg -t get_outputs | jq -r '.[] | select(.active == true) | .name'`
do
    IMAGE=/tmp/$OUTPUT-lock.png
    grim -o $OUTPUT $IMAGE
    corrupter -mag 1 -boffset 1  -meanabber 20 $IMAGE $IMAGE
    composite -gravity center $IMAGE $IMAGE
    LOCKARGS="${LOCKARGS} --image ${OUTPUT}:${IMAGE}"
    IMAGES="${IMAGES} ${IMAGE}"
done
swaylock $LOCKARGS
rm $IMAGES
