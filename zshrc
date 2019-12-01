# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SHELL=$ZSH_NAME

ZSH_THEME="af-magic"
TERM=xterm-256color

DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
plugins=(git vi-mode vim-interaction)

source $ZSH/oh-my-zsh.sh

bindkey '\eOA' history-beginning-search-backward
bindkey '\e[A' history-beginning-search-backward
bindkey '\eOB' history-beginning-search-forward
bindkey '\e[B' history-beginning-search-forward

function new-tmux-session {
  tmux new-session -As `basename $PWD`
}

# Aliases

alias dcm="docker-machine"
alias dcp="docker-compose"
alias e="$EDITOR"
alias gcp="gc \"$@\" && gp"


function t() {
  tmux attach -t $1 || tmux new -s $1
}

function fe() {
  e $(git ls-files -co --exclude-standard | peco --initial-filter SmartCase --prompt "> " --layout bottom-up)
}

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.private.zshrc ] && source ~/.private.zshrc

export FZF_DEFAULT_COMMAND='ag -g ""'
export PATH="/usr/local/opt/curl/bin:$PATH"
