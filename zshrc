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

setopt autocd
.{1..9} (){ local d=.; repeat ${0:1} d+=/..; cd $d;}
#
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%{$fg[blue]%}${PWD/#$HOME/~} %{$fg[yellow]%}${vcs_info_msg_0_}'$'\n''%{$fg[red]%}❯ %{$reset_color%}'

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

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
REPORTTIME=3

setopt SHARE_HISTORY

alias history="history 1"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init -)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.claude/local:$PATH"

alias claude="~/.claude/local/claude"

alias g='git'
alias ga='git add'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gca='git commit -a -m'
alias gpu='git push -u origin HEAD'
alias gst='git status'

alias l='ls -la'
alias ..='cd ..'

function gac() {
  if [ -z "$3" ]; then
    echo "Please provide a commit message"
    return 1
  fi

  git add --interactive && git commit $2 -m "$1: $3"
}

function gsync() {
    if [ -z "$1" ]; then
        echo "Usage: gsync <branch_name>"
        return 1
    fi

    local target_branch="$1"
    local base_branch=""

    # Check if main or master exists and set base_branch
    if git show-ref --verify --quiet refs/heads/main; then
        base_branch="main"
    elif git show-ref --verify --quiet refs/heads/master; then
        base_branch="master"
    else
        echo "Neither main nor master branch found"
        return 1
    fi

    # Fetch latest changes
    git fetch

    # Switch to target branch
    git checkout $target_branch || return 1

    # Pull changes from target branch's remote
    git pull origin $target_branch

    # Pull changes from base branch
    git pull origin $base_branch

    git push origin $target_branch

    git checkout $base_branch

    echo "Synced $target_branch with origin/$target_branch and origin/$base_branch"
}

# Platform-specific configuration
case "$(uname)" in
  Darwin)
    [[ -f ~/.zshrc.darwin ]] && source ~/.zshrc.darwin
    ;;
  Linux)
    [[ -f ~/.zshrc.linux ]] && source ~/.zshrc.linux
    ;;
esac

# Machine-specific secrets (not tracked in git)
[[ -f ~/.secrets ]] && source ~/.secrets
