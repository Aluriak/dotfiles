################################################################################
# ALIASES
################################################################################
# vim
alias vt='vim note:thesis'
alias vh='vim note:dictiaurus'

# battery
alias battery_all='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias battery='battery_all | grep percentage'
alias battery_time='battery_all | grep "time to"'

# soft
alias cytoscape='bg ~/bin/cytoscape-2.8.3/cytoscape.sh'



################################################################################
# FUNCTIONS
################################################################################
function tel {
    curl https://intranet.irisa.fr/intranet-fs/ami/cgi-bin/tel.pl\?args=`echo $* |sed -e "s/ /%20/g"`;
}


function cpsolvers() {
    TOPOP=$(pwd)
    cp ~/bin/clingor/clingo-4.5.4-linux-x86_64/gringo $TOPOP/gringo4
    cp ~/bin/clasp-3.1.5 $TOPOP/clasp
    cp $TOPOP/gringo4 $TOPOP/gringo3
}

function install_pyasp() {
    pip install pyasp
    cd venv/lib/python3.5/site-packages/pyasp/bin
    cpsolvers
    cd -
}

function install_selflib() {
    cd venv/lib/python3.5/site-packages/
    ln -s ~/Python/gen_graph/ "$(pwd)"
    ln -s ~/Python/solving/ "$(pwd)"
    ln -s ~/Python/3D/ "$(pwd)/plot3d"
    srenv
    pip install matplotlib numpy
    cd -
    install_pyasp
}
