# keyboard management script
# usage examples:
#   keyboard.sh setup
#   keyboard.sh set bepoz
#   keyboard.sh switch
#   keyboard.sh show
#   keyboard.sh i3status

detect_current() {
    layout=$(setxkbmap -query | grep layout | cut - -c 13-)
    variant=$(setxkbmap -query | grep variant | cut - -c 13-)

    if [[ $layout == "fr" ]];
    then
        if [[ $variant == "bepoz" ]];
        then
            echo "bepoz"
        elif [[ $variant == "bepo" ]];
        then
            echo "bepo"
        else
            echo "azerty"
        fi
    elif [[ $layout == "us" ]];
    then
        echo "qwerty"
    fi
}


k_set () {
    if [[ $1 == "bepoz" ]];
    then
        setxkbmap fr bepoz
    elif [[ $1 == "bepo" ]];
    then
        setxkbmap fr bepo
    elif [[ $1 == "fr" ]];
    then
        setxkbmap fr
    elif [[ $1 == "azerty" ]];
    then
        setxkbmap fr
    elif [[ $1 == "us" ]];
    then
        setxkbmap us
    elif [[ $1 == "qwerty" ]];
    then
        setxkbmap us
    else
        echo "invalid argument: \"$1\""
    fi
}

k_show () {
    # show the keyboard current layout
    layout=$(detect_current)
    echo $layout
    notify-send --expire-time=400 "$layout"
}

k_switch () {
    layout=$(detect_current)
    if [[ $layout == "bepoz" ]];
    then
        setxkbmap fr bepo
    elif [[ $layout == "bepo" ]];
    then
        setxkbmap fr bepo
        setxkbmap fr
    elif [[ $layout == "azerty" ]];
    then
        setxkbmap fr bepo
        setxkbmap us
    elif [[ $layout == "qwerty" ]];
    then
        setxkbmap fr bepo
        setxkbmap fr bepoz
    else
        setxkbmap fr bepo
        echo "invalid layout: \"$layout\""
    fi
}



if [[ $1 == "i3status" ]];
then
    # show the keyboard current layout in i3.
    # Use  bar { status_command <this script path> i3status } in ~/.i3/config
    while true;
    do
        echo "$(detect_current)  "
        sleep 1
    done


elif [[ $1 == "show" ]];
then
    k_show


elif [[ $1 == "setup" ]];
then
    # use bepo if bepoz is not installed
    k_set bepo
    k_set bepoz


elif [[ $1 == "switch" ]];
then
    k_switch
    k_show


elif [[ $1 == "set" ]];
then
    k_set $2

else
    echo "invalid action: $1"
    echo "available actions: i3status, show, setup, switch, set"
fi
