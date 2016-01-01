# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="pygmalion"
TERM=screen-256color

DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
plugins=(git svn svn-fast-info vi-mode vim-interaction)

source $ZSH/oh-my-zsh.sh

bindkey '\eOA' history-beginning-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\eOB' history-beginning-search-forward
bindkey '\e[B' history-beginning-search-forward

function new-tmux-session {
  tmux new-session -As `basename $PWD`
}

# Aliases

alias e="$EDITOR"
alias tnew="new-tmux-session"
alias dcm="docker-machine"
alias dcp="docker-compose"

# Colors

COLORS="$HOME/.vim/bundle/vim-hybrid-material/base16-material/base16-material.dark.sh"

if [ -f $COLORS ]; then
    source $COLORS
fi
