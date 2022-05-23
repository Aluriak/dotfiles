# keyboard management script
# usage examples:
#   keyboard.sh setup
#   keyboard.sh set bepoz
#   keyboard.sh switch
#   keyboard.sh show
#   keyboard.sh i3status


has_xkblayout_state=$(which xkblayout-state 2>/dev/null || echo "no")
# xkblayout-state was found here:  https://github.com/nonpop/xkblayout-state
#  it was installed from AUR, package xkblayout-state-git

# notify user of the currently used keyboard layout
# if xkblayout-state is not installed, nothing will happen
if [[ $has_xkblayout_state == "no" ]];
then
    k_show () {
        # cannot do that without xkblayout-state
        ""
    }
    k_switch () {
        # cannot do that without xkblayout-state
        ""
    }
    k_i3status() {
        # show the keyboard current layout in i3.
        # Use  bar { status_command <this script path> i3status } in ~/.i3/config
        while true;
        do
            echo "xkblayout-state not installed"
            sleep 1
        done
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
        elif [[ $1 == "us" ]];
        then
            setxkbmap us
        else
            echo "invalid argument: \"$1\""
        fi
    }

else  # xkblayout-state is available
    k_show () {
        # show the keyboard current layout
        notify-send --expire-time=400 "$(xkblayout-state print '%c/%C:  %s %v')"
        # xkblayout-state was found here:  https://github.com/nonpop/xkblayout-state
        #  it was installed from AUR, package xkblayout-state-git
    }
    k_i3status() {
        # show the keyboard current layout in i3.
        # Use  bar { status_command <this script path> i3status } in ~/.i3/config
        while true;
        do
                echo "$(xkblayout-state print '%s %v    ')"
            sleep 1
        done
    }
    k_switch () {
        xkblayout-state set +1
        ~/scripts/keyboard-show.sh
    }
    k_set() {
        set_keyboard () {
            ./keyboard-setup.sh
            xkblayout-state set $1
            ./keyboard-show.sh
        }
        if [[ $1 == "bepoz" ]];
        then
            set_keyboard 0
        elif [[ $1 == "bepo" ]];
        then
            set_keyboard 1
        elif [[ $1 == "fr" ]];
        then
            set_keyboard 2
        elif [[ $1 == "us" ]];
        then
            set_keyboard 3
        else
            echo "invalid argument: \"$1\""
        fi
    }
fi




k_setup () {
    # use, in that order : bepoz, bepo, azerty, qwert
    setxkbmap -layout "fr,fr,fr,us" -variant "bepoz,bepo,,"

    # DEACTIVATED: made with i3 and xkblayout-state, to get the switch
    #  AND a notification indicating the new keyboard layout.
    # enable cycling between keymaps with rshift+lshift.
    # setxkbmap -option grp:shifts_toggle
    # setxkbmap -option grp:ctrl_alt_toggle

    # to list available options:
    #  localectl list-x11-keymap-options | grep grp:
    # to list active options:
    #  setxkbmap -query
    # to remove all active options:
    #  setxkbmap -option
}


if [[ $1 == "i3status" ]];
then
    k_i3status


elif [[ $1 == "show" ]];
then
    k_show


elif [[ $1 == "setup" ]];
then
    k_setup


elif [[ $1 == "switch" ]];
then
    k_switch


elif [[ $1 == "set" ]];
then
    k_set $2

else
    echo "invalid action: $1"
    echo "available actions: i3status, show, setup, switch, set"
fi
