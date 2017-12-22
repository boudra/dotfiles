# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="pygmalion"
TERM=xterm-256color

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

alias tnew="new-tmux-session"
alias dcm="docker-machine"
alias dcp="docker-compose"
alias e="$EDITOR"

function fe() {
  e $(git ls-files -co --exclude-standard | peco --initial-filter SmartCase --prompt "> " --layout bottom-up)
}

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then source "/$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then source "/$HOME/google-cloud-sdk/completion.zsh.inc"; fi
