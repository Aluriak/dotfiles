

hpath=$(pwd)


if [ ! -e zsh/zsh-snap/zsh-snap/znap.zsh ];
then
    mkdir zsh/zsh-snap
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git zsh/zsh-snap/zsh-snap
    cd zsh/zsh-snap/zsh-snap
    source install.zsh
    cd ../../../
fi


# install dotfiles
ln -fs $hpath/.Xdefaults ~/
ln -fs $hpath/.zshrc ~/
ln -fs $hpath/vim/vimrc ~/.vimrc
ln -fs $hpath/vim/vimrc.bepo ~/.vimrc.bepo
ln -fs $hpath/vim/vimrc.bepoz ~/.vimrc.bepoz
ln -fs $hpath/vim/vimrc.simple ~/.vimrc.simple
ln -fs $hpath/vim/nvimrc ~/.config/nvim/init.vim
ln -fs $hpath/kitty.conf ~/.config/kitty/
ln -fs $hpath/i3/config ~/.i3/

# install scripts
mkdir -p ~/scripts
for sc in $hpath/scripts/*;
do
    ln -fs $sc ~/scripts/
done

# put git aliases if not already present
touch $home
if [ -z $(grep "\[alias\]" "~/.gitconfig") ];
then
    cat $hpath/.gitconfig >> ~/.gitconfig
fi

echo "done!"

# install of needed packages.
if [[ $DOTCONF == "arch" ]];
then
    sudo pacman -Syu --noconfirm --needed vim zsh thunderbird firefox inkscape gimp steam-manjaro base-devel git kitty python-pip python-virtualenv cmake
fi

# installation of vim-plug
#  see https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# installation of all plugins  (needs base-devel and cmake, so must be done after packages installation)
vu

