

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
function install_dotfile() {
    mkdir -p $(dirname "$hpath/$1")
    ln -fs $hpath/$1 $2
    echo "installed $hpath/$1 at $2"
}
install_dotfile .Xdefaults ~/
install_dotfile .zshrc ~/
install_dotfile vim/vimrc ~/.vimrc
install_dotfile vim/vimrc.bepo ~/.vimrc.bepo
install_dotfile vim/vimrc.bepoz ~/.vimrc.bepoz
install_dotfile vim/vimrc.simple ~/.vimrc.simple
install_dotfile vim/nvimrc ~/.config/nvim/init.vim
install_dotfile kitty.conf ~/.config/kitty/
install_dotfile i3/config ~/.i3/

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
