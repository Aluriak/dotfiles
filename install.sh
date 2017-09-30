#########################################
# DOTFILES
#########################################
# Current directory
DOTDIR=$(dirname $(realpath $0))

# Now create a private file and a specific file if necessary
touch "$(hostname).sh" privates.sh

# Avoid push of modifications of the private file
git update-index --assume-unchanged privates.sh


#########################################
# NEOVIM
#########################################
# installation for neovim
mkdir -p ~/.config/nvim
ln -s "${DOTDIR}"/.nvimrc ~/.config/nvim/init.vim

# installation of neovim's data
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install all packages
nvim -c PlugUpdate


#########################################
# VIM
#########################################
#TODO
