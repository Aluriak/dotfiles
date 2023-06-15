#!/usr/bin/zsh -i

# get the default current env informations
base_path=/home/lucas
more_path=
else_path=
CURENV_SOURCE_VENV=no


# get the current env informations, if it exists
current_env_file='/home/lucas/scripts/.current-env.sh'
if [ -e $current_env_file ];
then
    source "${current_env_file}"
fi
echo $CURENV_SOURCE_VENV
echo $CURENV_OPEN_HTOP
echo $CURENV_RUN_TESTS
echo $CURENV_OPEN_VIM_SESSION
echo $CURENV_PATH_1

base_path=$CURENV_PATH_1
more_path=$CURENV_PATH_2
else_path=$CURENV_PATH_3


# performe env opening
if [[ ${CURENV_OPEN_HTOP} = 'yes' ]];
then
    open-kitty "/home/lucas" wk-1 htop
fi

if [ $CURENV_SOURCE_VENV = 'yes' ];
then
    source_venv=srenv
else
    source_venv=
fi


if [ $CURENV_RUN_TESTS = 'yes' ];
then
    open-kitty "$base_path" wk-4 "$source_venv" "make test"
else
    open-kitty "$base_path" wk-4 "$source_venv"
fi


if [ $CURENV_OPEN_VIM_SESSION = 'yes' ];
then
    open-kitty "$base_path" wk-3 "$source_venv" "vs"
else
    open-kitty "$base_path" wk-3 "$source_venv"
fi


if [ $more_path != "" ];
then
    open-kitty "$more_path" wk-5 $source_venv
fi
if [ $else_path != "" ];
then
    open-kitty "$else_path" wk-6 $source_venv
fi
