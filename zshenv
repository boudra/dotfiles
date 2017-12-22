export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH
export PATH=$HOME/.node/bin:$PATH
export PATH=$HOME/.bin:$PATH
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim

# Colors

COLORS="$HOME/.vim/bundle/vim-hybrid-material/base16-material/base16-material.dark.sh"

if [ -f $COLORS ]; then
    source $COLORS
fi
