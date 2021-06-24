# zsh setup

# zsh hook function, called when the working directory change.
function chpwd() {
    verbosels --color .
}

# zsh hook function, called after the command.
function precmd() {
    bell
}

# source virtualenv when starting from virtualenv
#  see: https://vi.stackexchange.com/a/7654
if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

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


# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" overwrite-mode
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
#Ctrl-left/right
bindkey '\e[1;5C' forward-word # ctrl right
bindkey '\e[1;5D' backward-word # ctrl left o
#alt-left/right
bindkey "\e[1;3C" forward-word
bindkey "\e[1;3D" backward-word
