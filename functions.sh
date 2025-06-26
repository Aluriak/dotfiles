# functions repository

# rerun last command, with $1 as the binary
#  >>> ll f.txt
#  >>> r v    # -> will run `v f.txt`
function redo_with_another_command() {
    cmd=$(history -1 | head -n 1 | sed -r "s/^\s*[0-9:\s]*\s*([^ ]+)(.*)$/$1 \2/")
    echo "$cmd"
    zsh -i -c "$cmd"
}

# like `tree .` but coloring anything matching the given expr
function gree() {
    if [ $# -eq 1 ]
    then
        tree . | egrep "*$1*|$" --color=always | less -R
    elif [ $# -eq 2 ]
    then
        tree . | egrep -v "^$2$" | egrep ".*$1.*|$" --color=always | less -R
    elif [ $# -eq 3 ]
    then
        tree . | egrep "^$3$" | egrep ".*$1.*|$" --color=always | less -R
    else
        tree | less
        echo "usage: $0 <pattern to colorize> <dir> <pattern to remove>"
    fi
}


function run_ruff_and_mypy_and_pytest() {
    ddindex=${@[(ie)--]}   # NB: zsh-only: at which index is double-dash in cli arguments
    #echo $ddindex
    if [[ $ddindex -le $# ]]; then
        # argument $ddindex is a double dash
        mypyoptions="${@:1:$ddindex-1}"
        argfiles="${@:$ddindex+1:$#}"
    else
        # no double dash means all params are files/dir to run checkers on
        mypyoptions=
        argfiles=$@
    fi

    echo "Checking $argfiles"
    echo "Mypy options: $mypyoptions"

    [[ -e venv/bin/mypy ]] && mypy_path=venv/bin/mypy || mypy_path=$(which mypy 2> /dev/null)   # use bin in venv if available
    [[ -e venv/bin/ruff ]] && ruff_path=venv/bin/ruff || ruff_path=$(which ruff 2> /dev/null)
    [[ -e venv/bin/pytest ]] && pytest_path=venv/bin/pytest || pytest_path=$(which pytest 2> /dev/null)
    echo "Mypy binary found at $mypy_path"
    echo "Ruff binary found at $ruff_path"
    echo "Pytest binary found at $pytest_path"


    if [[ -e $ruff_path ]]
    then
        echo "Running ruff…"
        $ruff_path check --ignore=E741,E701,F401,E402,F403,E731  $argfiles
    else
        echo "No ruff binary found"
    fi

    if [[ $? && -e $mypy_path ]]
    then
        echo "Running mypy…"
        $mypy_path --pretty --disable-error-code var-annotated --disable-error-code no-redef --disable-error-code import-untyped --implicit-optional --warn-unused-ignores --check-untyped-defs $mypyoptions $argfiles
    fi

    if [[ $? && -e $pytest_path ]]
    then
        echo "Running pytest…"
        $pytest_path --doctest-module -vv $pytestoptions $argfiles
    fi
}


# Run ssh-agent, or, if it seems to have been created since startup, load it.
function load_ssh_agent() {
    if [[ -f "$HOME/.ssh-agent-proc" ]];
    then
        source "$HOME/.ssh-agent-proc"
    fi
}
function create_or_load_ssh_agent() {
    load_ssh_agent
    if [[ $SSH_AGENT_PID ]];
    then
        workingagent=$(ps "-$SSH_AGENT_PID" | grep ssh-agent)
        if [[ "$workingagent" ]];
        then
            echo Agent loaded
            return
        fi
    fi
    echo A new agent is to be created
    create_ssh_agent
}
function create_ssh_agent() {
        to_eval=$(ssh-agent)
        eval $to_eval
        echo $to_eval > "$HOME/.ssh-agent-proc"
        ssh-add
}
function clear_ssh_agent() {
    killall ssh-agent
    rm "$HOME/.ssh-agent-proc"
}


# create a virtualenv, source it, and populate it with requirements.txt if any.
function crenv_func() {
    virtualenv venv -p /usr/bin/python3
    source venv/bin/activate
    test -f requirements.txt && pip install -r requirements.txt
    test -f setup.cfg && python -c "import configparser; c = configparser.ConfigParser(); c.read('setup.cfg'); print(c['options'].get('install_requires', ''), c['options'].get('setup_requires', ''))" | xargs pip install -U
}

# add utf8 BOM to given files
function add-bom() {
    if [ $# -eq 0 ]
    then
            echo usage: $0 files ...
            exit 1
    fi

    for file in "$@"
    do
            echo "# Processing: $file" 1>&2
            if [ ! -f "$file" ]
            then
                    echo Not a file: "$file" 1>&2
                    exit 1
            fi
            TYPE=`file - < "$file" | cut -d: -f2`
            if echo "$TYPE" | grep -q '(with BOM)'
            then
                    echo "# $file already has BOM, skipping." 1>&2
            else
                    ( mv "${file}" "${file}"~ && uconv -f utf-8 -t utf-8 --add-signature < "${file}~" > "${file}" ) || ( echo Error processing "$file" 1>&2 ; exit 1)
            fi
    done
}

# use git clone on given github repository from username aluriak
#  then jump in it
# usage:
#   clone_by_ssh arpeggio
function clone_by_ssh() {
    git clone "git@github.com:aluriak/${1}.git"
    cd "${1}"
    clear
    ls
}
function clone_by_https() {
    git clone "https://github.com/aluriak/${1}.git"
    cd "${1}"
    clear
    ls
}


# ignore modifications of a file
function git-ignore-changes() {
    git update-index --assume-unchanged "${1}"
    echo "ran: git update-index --assume-unchanged ${1}"
}


function edit_clipboard() {
    xclip -o -selection clipboard | vipe | xclip -i -selection clipboard
    xclip -o -selection clipboard | xclip -i -selection primary
    xclip -o -selection clipboard | xclip -i -selection secondary
}

function expanded_watch() {
    args="\"${@:1}\""
    watch zsh -c "$args"
}

# easily open any terminal to perform given actions
# run the commands, then zsh. This won't allow to set variables or aliases.
# see open-kitty for a better working solution.
function open-term {
    # open-term <dir> <title> <commands>
    args="${@:3} ; zsh -i"
    # we need to first save the complete command in a variable,
    #  else it won't be correctly expanded in the kitty command.
    # echo $args
    if [[ -d "$1" ]]
    then
        kitty -T $2 --detach --hold -d "$1" -- zsh -i -c $args
    else
        echo "Invalid path: $1"
    fi
}

# easily open a kitty terminal to perform given actions
# uses the remote control feature of kitty to send commands to the remote
function open-kitty {
    # open-kitty <dir> <title> <command1> <command2> ... <commandn>
    uid=$(shuf -i 1-99999999999 -n 1)
    socket="unix:/tmp/kitty-rc-${uid}"
    /usr/bin/kitty --title $2 --detach -d \"$1\" --listen-on=${socket} --config ~/.config/kitty/kitty.conf
    sleep 1  # wait for kitty to be there before sending the commands
    for arg in ${@:3}
    do
        /usr/bin/kitty @ --to=${socket} send-text "${arg}\n"
    done
}


# launch autojump, then clear and list newly entered directory
function extend_autojump() {
    \j $@
    command clear
    ls
}
function extend_autojump_subdir() {
    \jc $@
    command clear
    ls
}


# Add in Makefile a recipe running parameters
function doom() {
    echo "all:\n\t$@" >> Makefile
}


# run given command, exit just after
function bg() {
    $@
    exit
}


# automatic ls pipe grep command
function ls_grep() {
    ls -R --color $1 | grep "${@:2}"
}
function ll_grep() {
    ls -l -R --color $1 | grep "${@:2}"
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


# create a directory, and go in it
function mkdor() {
    mkdir $@
    cd $1
}


# Aliase for 'boilr template use $1 .'
function boilr_use_shortcut() {
    ~/bin/boilr template use $1 . ${@:2}
}
# Aliase for 'boilr template save . $1'
function boilr_save_shortcut() {
    ~/bin/boilr template save . $@
}


# kill all processes to which command match a given pattern
# usage:
#     tkt "python __main__.py"
# see http://unix.stackexchange.com/a/50573/185486
function tkt() {
    for pid in $(ps -ef | grep "$1" | awk '{print $2}'); do kill -9 $pid; done
}


# cat lines of given file
# from the X-th line to the Y-th line (inclusive)
function kat() {
    if [[ $(($3 - $2)) -lt 0 ]];
    then
        >&2 echo "Given starting line is higher than finishing line."
    else
        < "$1" tail -n +"$2" | head -n "$(($3 - $2))"
    fi
}

# print files containing the regex
#   sonar <regex> [dir] [supplementary grep options]
# ex: sonar IMAGE .
#     sonar def src/ -w
#     sonar def . wl
# see http://stackoverflow.com/a/16957078
function sonar() {
    grep -rnI ${@:3} --color $2 -e "$1"
    # r: recursive
    # n: line number
    # I: ignore binary files
    # Others (usage as third parameter):
    # w: full word match only
    # l: filename only
}
function sonar_file() {
    sonar $1 $2 -l ${@:3}
}
function sonar_except() {
    sonar $1 $2 --exclude-dir="$3" ${@:4}
}

# Like sonar, but run vim on found files instead of printing matches to the doc
function vonar() {
    files=$(sonar $1 $2  --exclude-dir="$3" | cut -d ':' -f1 | uniq)
    if [[ $files ]];
    then
        # echo found: $files
        echo $files | xargs -o vim -c "/$1" -p
    else
        echo "no file matching given pattern"
    fi
}

# Convert all *.srt files in directory in unicode with iconv.
# If second argument is given, it is the input format for iconv. Default is ISO-8859-1.
function subtitle-in-unicode {
    # input format determination
    inputformat=ISO-8859-1
    if [ $# -eq 2 ]
    then
        inputformat=$2
    fi
    # handle all available srt files
    for srt in *.srt
    do
        iconv  -f "${inputformat}" -t utf8 ${srt} -o "${srt}.u"
        mv "${srt}" "${srt}.bak"
        mv "${srt}.u" "${srt}"
    done
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
    openers[xls]="libreoffice"
    openers[xlsx]="libreoffice"
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
    openers[rar]="unrar l"
    openers[7z]="7z l"
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
    alt_openers[rar]="unrar x"
    alt_openers[7z]="7z x"

    # In all other cases, use the default openers
    DEFAULT_OPENER="nvim"

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
    state=$("$DOTFILES_DIR/scripts/verbosels.py" "$1")
    if [ $state == 1 ]; then  # existing files
        # keep OSX compatibility by putting options first
        # ${@:2}: access to all param but the first
        command ls "${@:2}" "$1"
    elif [[ $state == 2 ]]; then  # hidden only
        echo "$1 contains only hidden files" 1>&2
    elif [[ $state == 3 ]]; then  # empty
        echo "$1 is empty" 1>&2
    elif [[ $state == 4 ]]; then  # it's a file
        command ls "${@:2}" "$1"
    elif [[ $state == 5 ]]; then  # path don't exists
        command ls "${@:2}" "$1"
    fi
}


# rotate an image with given angle, or 90 degrees
function rotateimg() {
    if [ $# -eq 2 ]
    then
        angle=$2
    else
        angle=90
    fi
    convert "$1" -rotate "$angle" .out.jpg
    mv .out.jpg "$1"
}

# for each given file, set it as background image, and ask for its new name (empty to keep it).
function rename-pics() {
    for file in $@
    do
        filename=$(basename -- "$file")
        extension=$(echo "${filename##*.}" | tr '[:upper:]' '[:lower:]')  # get file extension in lowercase
        feh -d --image-bg black --bg-max "$file"  # as background
        echo -n "new name: "
        read newname
        newfilename="$newname.$extension"
        if [[ -z "$newname" ]]  # empty new name
        then
            echo "Empty target. Nothing to do."
        elif [[ -f "$newfilename" ]]  # if new name already in use
        then
            echo "file $newfilename already exists. Nothing to do."
        else  # the new name is valid
            mv "$file" "$newfilename"
            echo "$file -> $newfilename"
        fi
    done
}


# Calling vim, then git add -p on edited files
function vim_then_git() {
    vim $@
    for arg in $@; do
        if [[ -f "$arg" ]]; then
            git add -p "$arg"
        fi
    done
}


# switch files $1 and $2
function switch_files () {
    if [ -f "$1" ]
    then
        if [ -f "$2" ]
        then
            tmp="${1}.tmp"
            while [ -f "$tmp" ]
            do
                tmp="${tmp}.tmp"
            done
            mv "$1" "$tmp"
            mv "$2" "$1"
            mv "$tmp" "$2"
        else
            echo "No file $2 found"
        fi
    else
        echo "No file $1 found"
    fi
}


function wr () {
    # write with keyboard inputs the given parameters
    sleep 2
    # first way: iter over parameters (by omitting the *in* clause of for loop), run for each one
    # inconvenient: does not put a space between the different parameters
    # for arg; do
        # xdotool type "$arg"
    # done
    # second way: make all parameter as a single value
    # inconvenient: put a space between parameters
    allargs=("$@")
    xdotool type "$allargs"
}


# get given files in clipboard, then edit it
function cpc() {
    cat $@ | xclip -sel clip
    edit_clipboard
}
# get given command in clipboard, then edit it
function ccc_func() {
    {"$@"} 2>&1 | xclip -sel clip
    edit_clipboard
}
# this alias is here to ensure that the first argument will be aliased too
alias 'ccc'='ccc_func '
