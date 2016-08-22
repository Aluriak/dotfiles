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


# automatic ls pipe grep command
function ls_grep() {
    ls $1 | grep "${@:2}"
}
function ll_grep() {
    ls -l $1 | grep "${@:2}"
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
    grep -rnI $3 --color $2 -e "$1"
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

    for nonescapedfilepath in "$@"
    do
        # get escaped version of given filename
        filepath=$(print -r -- "${(q)nonescapedfilepath}")
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
        extension=$(echo "$extension" | tr -d "[:space:]")

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
        echo "$command"
        echo "$command" | sh
    done
}





# Wrapper around ls command, printing dedicated messages
#  if directory is empty/full of hidden files.
#  Parse parameters in order to call verbosels_onefile correctly.
#  Code review: http://codereview.stackexchange.com/a/139237/115420
function verbosels() {
    # extract options and filepaths
    ls_options=()  # empty array
    ls_filepaths=()  # empty array
    for parameter in "$@"; do
        # it's an option if it's start with a dash
        if [[ "$parameter" == -* ]]; then
            #echo "OPTION: |$parameter|"
            ls_options+=($parameter)
        else  # it's a path: call ls on it
            # get escaped version of given filename
            filepath=$(print -r -- "${(q)parameter}")
            ls_filepaths+=($filepath)
            #echo "FILEPATH: |$filepath|"
        fi
    done
    # working directory if no directory given
    if [ ${#ls_filepaths[@]} = 0 ]
    then
        ls_filepaths+=(".")
    fi
    first=1  # false after the first iteration
    # call verbosels_onefile for each filepath
    for filepath in $ls_filepaths; do
        # print space only between ls calls
        if [ ! "$first" ]; then
            echo  # line jump
        else
            first=  # empty
        fi
        #echo "CMD: |verbosels_onefile ${^ls_options} $filepath|"
        _verbosels_onefile $filepath ${^ls_options}
    done
}


# Perform an ls call on only one directory/file, that must be in first parameter.
# The other parameters remain untouched.
# The ls call take into account any aliases on ls.
# This function is called by the higher level verbosels function.
function _verbosels_onefile() {
    if [ -d "$1" ]; then
        # contains files (hidden included)
        if [ -n "$(command ls -A "$1")" ]; then
            if [ -n "$(command ls "$1")" ]; then
                # keep OSX compatibility by putting options first
                # ${@:2}: access to all param but the first
                command ls "${@:2}" "$1"
            else
                # the directory is not empty, and contains only hidden files:
                # print message only if the ls command returns nothing
                # NOTE: run the ls command twice. Could be costly.
                if [ -n "$(command ls "$@")" ]; then
                    command ls "$@"
                else
                    echo "$1 contains only hidden files" 1>&2
                fi
            fi
        else
            echo "$1 is empty" 1>&2
        fi
    elif [ -e "$1" ]; then  # is a file, not a directory
        # keep OSX compatibility by putting options first
        # ${@:2}: access to all param but the first
        command ls "${@:2}" "$1"
    else
        echo "$1 doesn't exists" 1>&2
    fi
}
