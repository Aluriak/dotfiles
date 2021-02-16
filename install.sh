

path=$(pwd)


if [ ! -e zsh/zsh-snap/zsh-snap/znap.zsh ];
then
    mkdir zsh/zsh-snap
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git zsh/zsh-snap/zsh-snap
fi


# install dotfiles
ln -s $path/.Xdefaults ~/
ln -s $path/.zshrc ~/
ln -s $path/.vimrc.bepo ~/
ln -s $path/.vimrc.bepoz ~/
ln -s $path/.nvimrc ~/.config/nvim/init.vim
ln -s $path/kitty.conf ~/.config/kitty/

# install scripts
mkdir -p ~/scripts
for sc in $path/scripts/;
do
    ln -s $sc ~/scripts/
done

# put git aliases
cat $path.gitconfig >> ~/.gitconfig
