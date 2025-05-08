export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

zstyle ':omz:update' mode reminder

COMPLETION_WAITING_DOTS="true"

plugins=(archlinux git)

# Don't put .zcomp* files in home dir.
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

source $ZSH/oh-my-zsh.sh

# User configuration
alias ls='ls --color=auto -lAv'
alias grep='grep --color=auto'

eval $(keychain --quiet --eval --agents ssh id_ed25519)

