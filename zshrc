# Created by newuser for 5.8
#
#
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b%u%c'
#
autoload -U colors && colors
#
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%{$fg[blue]%}${PWD/#$HOME/~} %{$fg[yellow]%}${vcs_info_msg_0_}'$'\n''%{$fg[red]%}❯ %{$reset_color%}'

eval "$(direnv hook zsh)"

export EDITOR=nvim

alias e="$EDITOR"

function t() {
  tmux attach -t $1 || tmux new -s $1
}

alias g='git'
alias ga='git add'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gc='git commit -v'
alias gst='git status'
