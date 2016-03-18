# functions repository


# launch autojump, then clear and list newly entered directory
function extend_autojump() {
    \j $1
    clear && ls
}


# notify-send after given command
function notify-after() {
    $@
    notify-send "job finished ! " -t 2
}
alias notaf='notify-after'


# urgent flag on the window
alias bell='echo -e "\a"'
