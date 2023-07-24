keyfile=/usr/share/X11/xkb/symbols/fr
here=$(dirname $0)
if [[ -z $(grep "bepoz" $keyfile) ]];
then
    echo "installing bepoz…"
    sudo cat $here/bepozdefinition.bak >> /usr/share/X11/xkb/symbols/fr
    echo "bepoz is now installed."
else
    echo "bepoz is installed."
fi
