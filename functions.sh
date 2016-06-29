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


# run given command, exit just after
function bg() {
    $@
    exit
}


# notify-send after given command
function notify-after() {
    $@
    notify-send "job finished ! " -t 2
}
alias notaf='notify-after'


# urgent flag on the window
alias bell='echo -e "\a"'


# open file without opener specification
function open() {
    # Automatically open given input file with the proper program
    # -s option allow to use the alternative openers for following files
    # open -s archive.tar.gz                  »»»»   extract
    # open archive.tar.gz                     »»»»   show file
    # open archive.tar.gz -s archive.tar.gz   »»»»   show file then extract

    # Declare mapping {extension: opener}
    declare -A openers
    VIEWTAR="tar ftv"
    openers[pdf]="evince"
    openers[doc]="libreoffice"
    openers[docx]="libreoffice"
    openers[mkv]="mplayer"
    openers[avi]="mplayer"
    openers[mp3]="mplayer"
    openers[flac]="mplayer"
    openers[wav]="mplayer"
    # archives
    openers[bz]=$VIEWTAR
    openers[bz2]=$VIEWTAR
    openers[gz]=$VIEWTAR
    openers[gz2]=$VIEWTAR
    openers[lzma]=$VIEWTAR
    openers[tgz]=$VIEWTAR
    openers[zip]="unzip -l"
    # images
    IMAGE_VIEWER="feh"
    openers[png]=$IMAGE_VIEWER
    openers[jpg]=$IMAGE_VIEWER
    openers[gif]=$IMAGE_VIEWER
    openers[bmp]=$IMAGE_VIEWER

    # Alternatives openers, used when USE_ALT is true
    USE_ALT=false
    declare -A alt_openers
    alt_openers[mkv]="vlc"
    alt_openers[avi]="vlc"
    alt_openers[mp3]="vlc"
    alt_openers[wav]="vlc"
    alt_openers[flac]="vlc"
    UNTAR="tar xvf"
    alt_openers[bz]=$UNTAR
    alt_openers[bz2]=$UNTAR
    alt_openers[gz]=$UNTAR
    alt_openers[gz2]=$UNTAR
    alt_openers[lzma]=$UNTAR
    alt_openers[tgz]=$UNTAR
    alt_openers[zip]="unzip"

    # In all other cases, use the default openers
    DEFAULT_OPENER="vim"

    # Declare which openers should be launch asynchronously {openers: async}
    # spaces between, before and after are necessary.
    ASYNC=" evince feh "

    for nonesapedfilepath in "$@"
    do
        # get escaped version of given filename
        filepath=$(print -r -- ${(q)nonesapedfilepath})
        echo "filepath: $filepath"

        # switch alternative use on -a or -s switch
        if [[ $filepath = "-s" ]] ;
        then
            if [ $USE_ALT = true ] ;
            then
                USE_ALT=false
            else
                USE_ALT=true
            fi
            continue
        fi

        # get file extension
        filename=$(basename "$filepath")
        extension="${filename##*.}"
        # remove surrounding spaces
        extension=$(echo $extension | tr -d [:space:])

        # pick the (alternative) opener
        if [ $USE_ALT = true ] ;
        then
            opener="${alt_openers[$extension]}"
        else
            opener="${openers[$extension]}"
        fi

        if [[ $opener ]] ;
        then
            command="$opener $filepath"
            if [[ $ASYNC == *" $opener "* ]] ;
            then
                command="$command &"
            fi
        else
            command="$DEFAULT_OPENER $filepath"
        fi
        echo $command
        echo $command | sh
    done
}
