

hpath=$(pwd)


if [ ! -e zsh/zsh-snap/zsh-snap/znap.zsh ];
then
    mkdir zsh/zsh-snap
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git zsh/zsh-snap/zsh-snap
fi


# install dotfiles
ln -s $hpath/.Xdefaults ~/
ln -s $hpath/.zshrc ~/
ln -s $hpath/.vimrc.bepo ~/
ln -s $hpath/.vimrc.bepoz ~/
ln -s $hpath/.nvimrc ~/.config/nvim/init.vim
ln -s $hpath/kitty.conf ~/.config/kitty/

# install scripts
mkdir -p ~/scripts
for sc in $hpath/scripts/;
do
    ln -s $sc ~/scripts/
done

# put git aliases
cat $hpath/.gitconfig >> ~/.gitconfig
