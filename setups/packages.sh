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
        pip \
        python \
        python \
        scrot \
        thunar \
        thunderbird \
        vim \
        virtualenv \
        vlc \
        wine \
        zsh
fi
