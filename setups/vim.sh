
# installation of vim-plug
#  see https://github.com/junegunn/vim-plug
if [ ! -e ~/.vim/autoload/plug.vim ];
then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # installation of all plugins  (needs base-devel and cmake, so must be done after packages installation)
    "${EDITOR} -c PlugUpgrade -c PlugUpdate -c qa"
    # aliased to «vu» in aliases.sh
fi
