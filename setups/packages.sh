# install packages needed for everyday use or later setup.
if [[ $DOTCONF == "arch" ]];
then
    echo "installing system package with pacman…"
    sudo pacman -Syu --noconfirm --needed vim zsh thunderbird firefox inkscape gimp base-devel git kitty python-pip python-virtualenv cmake thunar scrot
fi
