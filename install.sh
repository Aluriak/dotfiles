

path=$(pwd)/


if [ ! -e antigen.zsh ];
then
	curl -L git.io/antigen > antigen.zsh
fi


# install dotfiles
ln -s $path.Xdefaults ~/
ln -s $path.zshrc ~/
ln -s $path.vimrc.bepo ~/
ln -s $path.vimrc.bepoz ~/
ln -s $path.nvimrc ~/.config/nvim/init.vim

# put git aliases
cat $path.gitconfig >> ~/.gitconfig
