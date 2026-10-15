#!/bin/bash

if [[ -f "$DEFAULT_LOCKSCREEN" ]]
then
    IMAGE=$DEFAULT_LOCKSCREEN
else
    echo "error: no default lockscreen image, envvar DEFAULT_LOCKSCREEN is empty" >&2
    IMAGE=
fi


if [[ "$1" == "blurr" && -x /usr/bin/spectacle ]]
then
    # take screenshot, blurr it, and lock screen with it
    spectacle -bfn -o "~/Pictures/lockscreen-todel.png"

    # convert "~/Pictures/lockscreen-todel.png" -blur 0x5 ~/Pictures/lockscreen.png  # slow
    convert "~/Pictures/lockscreen-todel.png" -resize 10% -resize 1000% "~/Pictures/lockscreen.png"  # quicker
    rm -f ~/Pictures/lockscreen-todel.png

    IMAGE=~/Pictures/lockscreen.png

elif [[ -f "$1" ]]
then
    IMAGE=$1

elif [[ "$1" ]]
then
    echo "error: given parameter \"$1\" is not a filepath nor "blurr" (or spectacle is not installed). Will use default lockscreen" >&2

fi

# echo $IMAGE
if [[ -f "$IMAGE" ]]
then
    i3lock --image "$IMAGE" -t --ignore-empty-password --show-failed-attempts
else
    i3lock                  -t --ignore-empty-password --show-failed-attempts
fi
