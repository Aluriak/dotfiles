# put git aliases if not already present
gitfile=~/.gitconfig
touch $gitfile
if [[ -z $(grep "[alias]" $gitfile) ]];
then
    cat $hpath/.gitconfig >> $gitfile
    echo "git aliases added to gitconfig"
fi
