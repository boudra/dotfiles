# Mohamed Boudra's dotfiles

Dotfiles I use on a daily basis for Arch Linux and OS X.

## Main Components

## Common

* **Fish** as the main shell
* **Nvim** as the main editor
* **Tmux** as the terminal multiplexer
* **Asdf** version manager
* **ripgrep** file search
* **kitty** as the terminal emulator

## Linux

* **i3** as the graphical environment

## Requeriments

#### Fish

Use ```fish``` as your user's default shell, you can enable it after installing with:

```
chsh -s $(which fish)
```

Sign out and sign in for it to take effect.

#### ripgrep

```
# OS X
brew install ripgrep

# Arch Linux
pacman -S ripgrep
```

Other platforms: https://github.com/BurntSushi/ripgrep#installation

#### JetBrains Mono

https://www.jetbrains.com/lp/mono/#how-to-install

## Installation

Run:
```
git clone --recursive https://github.com/boudra/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

The ```--recursive``` part is important for fetching the submodules.

The install script will ask your confirmation before overwriting any existing config files, if you want to force overwriting use:

```
~/dotfiles/install.sh -f
````
