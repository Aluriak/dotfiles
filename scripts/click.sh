#!/bin/bash
PFILE=/home/lucas/.clicking
LFILE=/home/lucas/.clicking-logs
if [[ "$1" = "run" ]]
then
    echo $$ > "$PFILE"
    echo "we are starting with pid $$" >> "$LFILE"
    while true
    do
        xdotool click --repeat 10 --delay 75ms 1
    done
elif [[ -f "$PFILE" ]]
then  # exists ; must be killed
    pid=$(cat "$PFILE")
    echo "must kill $pid…" >> "$LFILE"
    kill -9 $pid
    rm "$PFILE"
elif [[ "$1" = "" ]]
then  # not started, let's start
    exec sh $0 run
fi
