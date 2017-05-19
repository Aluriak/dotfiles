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



# THEME

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
BULLETTRAIN_PROMPT_ORDER=(
    # status
    # custom
    context
    dir
    virtualenv
    # git
)
BULLETTRAIN_PROMPT_CHAR="❯"
BULLETTRAIN_CONTEXT_BG='blue'
BULLETTRAIN_PROMPT_SEPARATE_LINE='false'
BULLETTRAIN_VIRTUALENV_BG='green'
BULLETTRAIN_VIRTUALENV_NAME=''

# APPLICATION
antigen apply
