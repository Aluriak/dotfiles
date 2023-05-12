

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
./install-scripts.sh

# detect system
source $hpath/host.sh

# various setups
source setups/packages.sh
source setups/bepoz.sh
source setups/vim.sh
source setups/git.sh

echo "done!"
