Development setup for Arch Linux and OS X.

## macOS Setup


```
zsh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval `/opt/homebrew/bin/brew shellenv`

brew install neovim tmux autoconf gnupg rg asdf direnv
brew install --cask spotify kitty tableplus firefox slack docker discord
```

## Installation

```
git clone --recursive https://github.com/boudra/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

