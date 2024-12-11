#!/bin/bash
# take screenshot, blurr it, and lock screen with it

spectacle -bfn -o ~/Pictures/lockscreen-todel.png

# convert ~/Pictures/lockscreen-todel.png -blur 0x5 ~/Pictures/lockscreen.png  # slow
convert ~/Pictures/lockscreen-todel.png -resize 10% -resize 1000% ~/Pictures/lockscreen.png  # quicker
rm ~/Pictures/lockscreen-todel.png

i3lock --image ~/Pictures/lockscreen.png --ignore-empty-password --show-failed-attempts
