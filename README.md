# Mohamed Boudra's dotfiles

This repository contains the dotfiles I use on a daily basis.

## Components

Altough the dotfiles have configurations for alot of tools, the ones I usually use are:

* **Zsh** as the main shell with [Oh my Zsh](https://github.com/robbyrussell/oh-my-zsh)
* **Vim** as the main editor
* **i3** as the graphical envirioment
* **Tmux** as the terminal multiplexer
* **Urxvt** as the terminal emulator

## Requeriments

Use ```zsh``` as your user's default shell, you can enable it after installing with:

```
chsh -s $(which zsh)
```

## Installation

Run:
```
git clone --recursive https://github.com/boudra/dotfiles ~/dotfiles
~/dotfiles/install.sh
```
The ```-recursive``` part is important for fetching the submodules.

The install script will ask your confirmation before overwriting any existing config files, if you want to force overwriting use:

```
~/dotfiles/install.sh -f
````
