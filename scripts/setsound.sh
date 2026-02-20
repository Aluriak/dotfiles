

if [[ "$1" =~ ^(\+|-)?([0-9]+)%?$ ]]
then
    op=${BASH_REMATCH[1]}
    amount=${BASH_REMATCH[2]}

elif [[ "$1" == "toggle" ]]
then
    op=toggle

else
    echo "usage examples:"
    echo "    +5%"
    echo "    -2%"
    echo "    toggle"
    exit 1

fi

if [[ $(which pactl 2> /dev/null) ]];
then
    if [[ $op == "toggle" ]]; then
        pactl set-sink-mute 0 toggle
    else
        pactl set-sink-volume 0 "${op}${amount}%"
    fi
fi
if [[ $(which amixer 2> /dev/null) ]];
then
    if [[ $op == "toggle" ]]; then
        amixer set Master toggle
    else
        amixer set Master "${amount}%${op}"
    fi
fi
