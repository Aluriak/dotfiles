# get host configuration (DOTCONF var)
source $(dirname $0)/host.sh

# setup: zsh
source $(dirname $0)/zsh_antigen.sh
source $(dirname $0)/zsh.sh

# setup: env
source $(dirname $0)/exports.sh

# setup: autojump
source /etc/profile.d/autojump.sh

# setup: functions and aliases
source $(dirname $0)/functions.sh
source $(dirname $0)/aliases.sh

# host dependent sources
source $(dirname $0)/${HOST}.sh

# non-public sources
source $(dirname $0)/privates.sh
