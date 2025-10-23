#!/bin/bash
# The following script will:
#  - show whether zswap is active or not and if active, give zswap parameters if run with the sudo command
#  - display a list of all applications / services that take up swap and how much they take up in descending order
# taken from https://wiki.manjaro.org/index.php/Swap
#Check whether running as root
if [ "$(whoami)" = 'root' ]; then
  dmesg | grep "zswap:" | grep --silent "load"
  if $? -eq 0 ; then
    # zswap is active
    echo "zswap information:"
    grep --recursive --color=none . /sys/kernel/debug/zswap/
    read -n 1 -s -r -p "Press any key to continue"
  else
    echo "[warning] zwap not active. Continuing"
  fi
else
  echo "[warning] Not running as root: skipping zswap info"
fi
for szFile in /proc/*/status ; do
  awk '/VmSwap|Name/{printf $2 "\t" $3}END{ print "" }' "$szFile"
done | sort --key 2 --numeric --reverse | more
