
# BROWSER
if [ -n "$DISPLAY" ]; then
    export BROWSER=firefox
else
    export BROWSER=links
fi

# EDITOR
export EDITOR=$(which vim)

# DOTFILES
export DOTFILES_DIR=$(dirname $0)

# LANG
export LANGUAGE=fr_FR
export LANG=fr_FR.UTF-8

# DIRS
export XDG_CONFIG_HOME=/home/lucas/.config

# PATH
export PATH="$PATH:/home/lucas/bin"

# Python
export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring



# KITTY
# fix kitty over ssh problem by using xterm conf.
#  see https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-when-sshing-into-a-different-computer
#      this solution isn't working well engouh, so:
# ALT solution : just use xterm conf. It just works.
#   see https://github.com/kovidgoyal/kitty/issues/713
export TERM=xterm
