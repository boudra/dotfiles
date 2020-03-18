# Mohamed Boudra's dotfiles

Dotfiles I use on a daily basis.

## Main Components

* **Zsh** as the main shell with [Oh my Zsh](https://github.com/robbyrussell/oh-my-zsh)
* **Nvim** as the main editor
* **Tmux** as the terminal multiplexer
* **Asdf** version manager
* **kitty** as the terminal emulator for both OS X and Arch
* **i3** as the graphical envirioment for Arch


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
