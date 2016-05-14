# functions repository

# Make sure only one ssha-agent process runs at a time
function sshag() {
    if ! pgrep -u $USER ssh-agent > /dev/null; then
        ssh-agent > ~/.ssh-agent-thing
    fi
    if [[ "$SSH_AGENT_PID" == "" ]]; then
        eval $(<~/.ssh-agent-thing)
    fi
    ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'
}


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
