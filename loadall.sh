# get host configuration (DOTCONF var)
source $(dirname $0)/host.sh

# setup: zsh
source $(dirname $0)/zsh/znap.zsh
source $(dirname $0)/zsh/zsh.sh

# setup: env
source $(dirname $0)/exports.sh

# setup: autojump
source $(dirname $0)/autojump.sh

# setup: functions and aliases
source $(dirname $0)/functions.sh
source $(dirname $0)/aliases.sh

# host dependent sources
source $(dirname $0)/hosts/${HOST}.sh

# non-public sources
source $(dirname $0)/privates.sh
