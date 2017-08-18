
# Current directory
DOTDIR=$(dirname $(realpath $0))

# installation for neovim
mkdir -p ~/.config/nvim
ln -s "${DOTDIR}"/.nvimrc ~/.config/nvim/init.vim 

# installation of neovim's data
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install all packages
nvim -c PlugUpdate
