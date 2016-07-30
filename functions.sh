# functions repository


# launch autojump, then clear and list newly entered directory
function extend_autojump() {
    \j $@
    clear && ls
}
function extend_autojump_subdir() {
    \jc $@
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


# urgent flag on the window
function bell() {
    echo -en "\a"
}
# urgent flag after given command
function bell-after() {
    $@
    bell
}


# print files containing the regex
#   sonar <regex> [dir] [supplementary grep options]
# ex: sonar IMAGE .
#     sonar def src/ -w
#     sonar def . wl
# see http://stackoverflow.com/a/16957078
function sonar() {
    grep -rnI $3 --color $2 -e $1
    # r: recursive
    # n: line number
    # I: ignore binary files
    # Others (usage as third parameter):
    # w: full word match only
    # l: filename only
}


# Comes from the ranger documentation.
# This is a bash function for .bashrc to automatically
# change the directory to the last visited one
# after ranger quits.
# To undo the effect of this function,
# you can type "cd -" to return to the original directory.
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}


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
