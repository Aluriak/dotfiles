

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
ln -fs $hpath/.vimrc.bepo ~/
ln -fs $hpath/.vimrc.bepoz ~/
ln -fs $hpath/.nvimrc ~/.config/nvim/init.vim
ln -fs $hpath/kitty.conf ~/.config/kitty/
ln -fs $hpath/i3/config ~/.i3/

# install scripts
mkdir -p ~/scripts
for sc in $hpath/scripts/*;
do
    ln -fs $sc ~/scripts/
done

# put git aliases if not already present
home=~/.gitconfig
if [ -z $(grep "\[alias\]" "$home") ];
then
    cat $hpath/.gitconfig >> ~/.gitconfig
fi

echo "done!"
