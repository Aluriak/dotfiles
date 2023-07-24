# Define the HOST variable, based on which computer is used
# and the much more important DOTCONF.

HOST=$(hostname)
if [[ $HOST == "hamilton" ]];
then
    HOST="hamilton"
    DOTCONF="arch"
elif [[ $HOST == "dijkstra" ]];
then
    DOTCONF="ubuntu"
elif [[ $HOST == "clodomir" ]];
then
    DOTCONF="arch"
else  # munin or puceron
    DOTCONF="arch"
fi
