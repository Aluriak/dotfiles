# see https://github.com/marlonrichert/zsh-snap#example-zshrc-file

source $(dirname $0)/zsh-snap/zsh-snap/znap.zsh

source $(dirname $0)/theme.zsh
znap prompt caiogondim/bullet-train.zsh


# bordel varié trouvé sur la doc
znap source ohmyzsh/ohmyzsh lib/{git,theme-and-appearance}
znap source ohmyzsh/ohmyzsh plugins/{git,pip}


export ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
znap source zsh-users/zsh-syntax-highlighting
