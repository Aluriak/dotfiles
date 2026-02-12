#!/bin/zsh
export EDITOR=vim
xclip -l -o -selection clipboard | vipe | nohup xclip -l -i -selection clipboard


xclip -o -selection clipboard | xclip -i -selection primary
xclip -o -selection clipboard | xclip -i -selection secondary
