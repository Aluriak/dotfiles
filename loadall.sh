function source_if_exists() {
    [[ -e "$1" ]] && source "$1"

}


# get host configuration (DOTCONF var)
source_if_exists $(dirname $0)/host.sh

# setup: zsh
source_if_exists $(dirname $0)/zsh/znap.zsh
source_if_exists $(dirname $0)/zsh/zsh.sh

# setup: env
source_if_exists $(dirname $0)/exports.sh

# setup: autojump
source_if_exists $(dirname $0)/autojump.sh

# setup: functions and aliases
source_if_exists $(dirname $0)/functions.sh
source_if_exists $(dirname $0)/aliases.sh

# host dependent sources
source_if_exists $(dirname $0)/hosts/${HOST}.sh

# non-public sources
source_if_exists $(dirname $0)/privates.sh
