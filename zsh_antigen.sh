autoload antigen

# Antigen
source $(dirname $0)/antigen.zsh

# Antigen remote source
antigen use oh-my-zsh


# PLUGINS

# git
antigen bundle git

# Explain how to install missing binary
antigen bundle command-not-found

# IPFS autocompletion
antigen bundle aramboi/zsh-ipfs

# ctrl-z as an alias of fg
antigen bundle fancy-ctrl-z

# zsh syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme
source $(dirname $0)/zsh_theme.sh

# APPLICATION
antigen apply
