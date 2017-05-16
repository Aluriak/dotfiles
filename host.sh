# Define the HOST variable, based on which computer is used
# and the much more important DOTCONF.

HOST=$(hostname)
if [[ $HOST == "hamilton.irisa.fr" ]];
then
    HOST="hamilton"
    DOTCONF="fedora_noroot"
else  # munin or puceron
    DOTCONF="arch"
fi
