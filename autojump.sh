
if [[ $DOTCONF == "arch" ]];
then
    source /etc/profile.d/autojump.sh
elif [[ $DOTCONF == "ubuntu" ]];
then
    source /usr/share/autojump/autojump.sh
fi

