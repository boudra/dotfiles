# Created by newuser for 5.8
#
#
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

eval "$(/opt/homebrew/bin/brew shellenv)"

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b%u%c'
#
autoload -U colors && colors

setopt autocd
.{1..9} (){ local d=.; repeat ${0:1} d+=/..; cd $d;}
#
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%{$fg[blue]%}${PWD/#$HOME/~} %{$fg[yellow]%}${vcs_info_msg_0_}'$'\n''%{$fg[red]%}❯ %{$reset_color%}'

# eval "$(direnv hook zsh)"

export EDITOR=nvim
export HUSKY=0
export LEFTHOOK=0
export DISABLE_ESLINT_PLUGIN=true

alias e="$EDITOR"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'

bindkey -v
bindkey '^R' history-incremental-search-backward

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey "^E" edit-command-line

ISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
REPORTIME=3

setopt SHARE_HISTORY

alias history="history 1"

function t() {
  tmux attach -t $1 || tmux new -s $1
}

function t() {
    declare sessionName="$1";
    shift;

    # Check if the Tmux session exists
    if ! tmux has-session -t="$sessionName" 2> '/dev/null';
    then
        # Create the Tmux session
        TMUX='' tmux new-session -ds "$sessionName";
    fi

    # Switch if inside of Tmux
    if [[ "${TMUX-}" != '' ]];
    then
        exec tmux switch-client -t "$sessionName";
    fi

    # Attach if outside of Tmux
    tmux attach -t "$sessionName";
}

# . "$HOME/.asdf/asdf.sh"
. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias g='git'
alias ga='git add'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gc='git commit -v'
alias gca='git commit -a -m'
alias gpu='git push -u origin HEAD'
alias gst='git status'


function gac() {
  if [ -z "$3" ]; then
    echo "Please provide a commit message"
    return 1
  fi

  git add --interactive && git commit $2 -m "$1: $3"
}

alias ..='cd ..'
