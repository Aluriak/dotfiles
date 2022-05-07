# Aliases uniletter
alias a="${EDITOR}"
alias b='bell'  # see functions.sh
alias c='extend_autojump_subdir'  # see functions.sh
alias d='date'
alias e="${EDITOR}"
alias f='exiftool'
alias g='git'
alias h='htop'
alias i='xclip -sel clip'
alias j='extend_autojump'  # see functions.sh
alias k='lsblk'
alias kf='lsblk -f'
alias l='verbosels -CF --color'  # see functions.sh
alias m='make'
alias n='notify-after '  # see functions.sh
alias o='open'
alias p='python3'
alias q='exit'
alias r='ranger-cd'  # see functions.sh
alias s='git status'
alias t='edit_clipboard'  # see functions.sh
alias u='xclip -o'
alias v="${EDITOR}"
alias w='expanded_watch '  # see functions.sh + trailing space to allows aliases
alias x='pdflatex'
alias y="${EDITOR}"
alias z="${EDITOR}"
alias ç='source ~/.zshrc'
alias é="${EDITOR} -c ":VimShell""

# Aliases git
alias cg='clone_by_ssh'  # see functions
alias ch='clone_by_https'  # see functions
alias ga='git add'
alias gap='git ap'
alias gcl='git cl'
alias gif='git cif'
alias gia='git cia'
alias gpl='git pl'
alias gps='git ps'
alias gst='git status'
alias st='git status'

# Aliases listing
alias ls='verbosels --color=auto'  # see functions.sh
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

# Aliases system
alias dodo='shutdown now -P'
alias sieste='shutdown now -r'
alias ni='nice -n 19 ionice -c3'  # see http://sebsauvage.net/links/?PfISxw
alias driver_status="hwinfo --gfx | grep 'Driver Status'"
alias font_update="fc-cache -fv"
alias errcho='>&2 echo'

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
alias 'cl'='clisp'
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

# Aliases functions
alias ba='bell-after '  # trailing space allow next word to use aliases
alias notaf='notify-after '
alias na='notify-after '
alias os='open -s'
alias opens='open -s'
alias uuid='ls -l /dev/disk/by-uuid'

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
alias boilr='~/bin/boilr'  # see https://github.com/tmrts/boilr
alias boirl='~/bin/boilr'
alias blr='~/bin/boilr'
alias brl='~/bin/boilr'
alias bl='~/bin/boilr template'
alias bp='~/bin/boilr template'
alias bt='~/bin/boilr template'
alias bs='boilr_save_shortcut'
alias bu='boilr_use_shortcut'
alias clasp='/usr/lib/python3.5/site-packages/pyasp/bin/clasp'
alias feh='feh -. -d --draw-tinted'
alias fhe='feh'
alias fe='feh'
alias ff='firefox'
alias fh='feh'
alias gringo='/usr/lib/python3.5/site-packages/pyasp/bin/gringo4'
alias ir='pip install -r requirements.txt'
alias iru='pip install -r requirements.txt -U'
alias lk='~/scripts/push_link/push_link.sh'
alias meh='feh'
alias mpl='mplayer'
alias mps='mpsyt'
alias ntop='nethogs'
alias nv="${EDITOR}"
alias p2='python2'
alias p3='python3'
alias prr='pip install -r requirements.txt'
alias rd='ranger-cd'  # see functions.sh
alias rg='ranger-cd'
alias rgr='ranger-cd'
alias vk='vimoku'
alias weechat='weechat-curses'
alias woman='eg'
alias ydl='youtube-dl'
alias yt='mpsyt'

# Aliases ssh
alias sshag='eval $(ssh-agent) && ssh-add'
alias sshad='sshag'
alias ssha='sshag'

# Aliases vim
alias vd="${EDITOR} -d"
alias vi="${EDITOR}"
alias vo="${EDITOR} -O"
alias vp="${EDITOR} -p"
alias vs="${EDITOR} -S Session.vim"
alias vims="${EDITOR} -S "
alias Vim="${EDITOR} -O"
alias V='Vim'
alias vu="${EDITOR} -c PlugUpgrade -c PlugUpdate -c qa"
alias vv="${EDITOR} -u ~/.vimrc.simple"

# Aliases virtualenv
alias crenv='crenv_func'  # see functions.sh
alias srenv='source venv/bin/activate'
alias psrenv='source ../venv/bin/activate'

# Aliases mouse
alias imi='cat /dev/null | vipe | xclip -sel clip'
alias imo='xclip -o'
alias xo='xclip -o'
alias ini='xclip -sel clip < '

# Aliases cal
alias cal='cal --three'

# Aliases make
alias mn='make --dry-run'
alias mt='make t'  # recipe name for tests
