# zsh setup

# zsh hook function, called when the working directory change.
function chpwd() {
    verbosels --color .
}

# zsh hook function, called after the command.
function precmd() {
    bell
}

# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
setopt CORRECT

# for sharing history between zsh processes
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# never ever beep ever
setopt NO_BEEP

# do not print error on non matched patterns
setopt nonomatch

# allow prompt substitutions
setopt prompt_subst
