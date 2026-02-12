# install packages needed for everyday use or later setup.
if [[ $DOTCONF == "arch" ]];
then
    echo "installing system package with pacman…"
    sudo pacman -Syu --noconfirm --needed \
        base-devel \
        blueman \
        chromium \
        cmake \
        evince \
        feh \
        firefox \
        gimp \
        git \
        gparted \
        inkscape \
        kitty \
        manjaro-bluetooth \
        moreutils \
        mplayer \
        pass \
        pavucontrol \
        python \
        python-pip \
        python-virtualenv \
        scrot \
        signal-desktop \
        steam-native-runtime \
        thunar \
        thunderbird \
        vim \
        vlc \
        wine \
        xsane \
        yay \
        zsh
fi
