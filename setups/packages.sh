# install packages needed for everyday use or later setup.
if [[ $DOTCONF == "arch" ]];
then
    echo "installing system package with pacman…"
    sudo pacman -Syu --noconfirm --needed \
        base-devel \
        blueman \
        cmake \
        chromium \
        evince \
        firefox \
        gimp \
        git \
        gparted \
        inkscape \
        kitty \
        pip \
        python \
        python \
        scrot \
        thunar \
        thunderbird \
        vim \
        virtualenv \
        zsh
fi
