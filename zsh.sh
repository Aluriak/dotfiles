# zsh setup

# zsh hook function, called when the working directory change.
function chpwd() {
    ls
}

# zsh hook function, called after the command.
function precmd() {
    bell
}
