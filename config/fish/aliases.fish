function g
    if test (count $argv) -ge 1
      git $argv
    else
      git st
    end
end

alias gst 'git status'
alias gdiff 'git diff'
alias gp 'git push'
alias ga 'git add'
alias gc 'git commit'
alias e '$EDITOR'
