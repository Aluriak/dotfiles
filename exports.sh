
# BROWSER
if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else
    export BROWSER=links
fi

# EDITOR
export EDITOR=nvim

# DOTFILES
export DOTFILES_DIR=$(dirname $0)
