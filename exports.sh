
# BROWSER
if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else
    export BROWSER=links
fi

# EDITOR
export EDITOR=$(which nvim)

# DOTFILES
export DOTFILES_DIR=$(dirname $0)

# LANG
export LANGUAGE=fr_FR
export LANG=fr_FR.UTF-8

# DIRS
export XDG_CONFIG_HOME=/home/lucas/.config
