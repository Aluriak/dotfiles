# install in the ~/scripts/ directory symlinks to all scripts found in scripts/ subdir.

hpath=$(pwd)
# install scripts
mkdir -p ~/scripts
for sc in $hpath/scripts/*;
do
    ln -fs $sc ~/scripts/
done
