set -x EDITOR nvim
set -x TERM xterm-256color

fish_vi_key_bindings

. ~/.config/fish/aliases.fish

set -g fisher_path ~/.config/fish/fisher
set -x FZF_DEFAULT_COMMAND 'rg --files --hidden --follow --glob "!.git"'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx PATH $PATH $HOME/.bin

eval (direnv hook fish)

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

for file in $fisher_path/conf.d/*.fish
  builtin source $file 2> /dev/null
end

function t
  tmux attach -t $argv[1] || tmux new -s $argv[1]
end

source ~/.asdf/asdf.fish
