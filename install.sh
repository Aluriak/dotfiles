

path=$(pwd)


if [ ! -e antigen.zsh ];
then
	curl -L git.io/antigen > antigen.zsh
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
