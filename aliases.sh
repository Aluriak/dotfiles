# Aliases uniletter
alias a='vim'
alias b='bell'  # see functions.sh
alias c='extend_autojump_subdir'  # see functions.sh
alias d='date'
alias e='vim'
alias f='exiftool'
alias g='git'
alias h='htop'
alias i='mkdir -p'
alias j='extend_autojump'  # see functions.sh
alias k='lsblk'
alias l='ls -CF --color'
alias m='make'
alias n='notify-after'  # see functions.sh
alias o='open'
alias p='python3'
alias q='exit'
alias r='ranger-cd'  # see functions.sh
alias s='git status'
alias t='vim'
alias u='vim'
alias v='vim'
alias w='watch'
alias x='pdflatex'
alias y='vim'
alias z='vim'
alias ç='source ~/.zshrc'
alias é='vim -c ":VimShell"'

# Aliases autojump

# Aliases env
alias wk='watch -n 1 lsblk'
alias ':q'='exit'
alias ':qa'='exit'
alias ':Q'='exit'
alias ':x'='exit'
alias ':xa'='exit'
alias 'xit'='exit'
alias 'actual'='source ~/.zshrc'
alias ':w'='source ~/.zshrc'
alias 'cls'='clear ; ls'
alias 'cl'='cls'
alias 'clr'='cls'
alias 'cln'='cls'
alias 'df'='df -h'

# Aliases git
alias gbr='git branch'
alias gpl='git pull'
alias gps='git push'
alias grb='git rebase'
alias gss='git stash'
alias gcl='git clone'

# Aliases grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Aliases listing
alias ls='ls --color=auto'
alias sl='ls'
alias LS='ls'
alias SL='ls'
alias lss='ls'
alias ll='ls -ahlF'
alias la='ls -a'
alias lr='ls -R'
alias lra='ls -AR'
alias lh='ls -larth'
alias lg='ls | grep'
alias llg='ll | grep'

# Aliases functions
alias ba='bell-after'
alias notaf='notify-after'
alias na='notify-after'
alias os='open -s'
alias opens='open -s'

# Aliases moves
alias 'dp'='pwd | xclip'
alias 'pd'='cd $(xclip -o) && clear && ls'
alias 'cls'='clear && ls'
alias 'cd.'='cd ..'
alias 'cd..'='cd ../..'
alias 'cd...'='cd ../../..'
alias 'cd....'='cd ../../../..'
alias 'cd.....'='cd ../../../../..'
alias 'cd......'='cd ../../../../../..'

# Aliases soft
alias clasp='/usr/lib/python3.5/site-packages/pyasp/bin/clasp'
alias gringo='/usr/lib/python3.5/site-packages/pyasp/bin/gringo4'
alias mpl='mplayer'
alias mps='mpsyt'
alias rd='ranger-cd'  # see functions.sh
alias rg='ranger-cd'
alias rgr='ranger-cd'
alias weechat='weechat-curses'
alias woman='eg'
alias yt='mpsyt'

# Aliases ssh
alias sshag='eval $(ssh-agent) && ssh-add'
alias sshad='sshag'
alias ssha='sshag'

# Aliases vim
alias vd='vimdiff'
alias vi='vim'
alias vo='vim -O'
alias vp='vim -p'
alias vs='vim -S Session.vim'
alias vims='vim -S'
alias Vim='vim -O'
alias V='Vim'
alias vv='vim -u ~/.vimrc.simple'

# Aliases virtualenv
alias crenv='virtualenv venv -p /usr/bin/python3'
alias srenv='source venv/bin/activate'