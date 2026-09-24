#!/bin/bash
set -euo pipefail

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)-$$"

# Full setup by default; --dotfiles-only only creates links.
DOTFILES_ONLY=0
case "${1:-}" in
    --dotfiles-only) DOTFILES_ONLY=1 ;;
    ''|-f) ;;
    *) echo "Usage: $0 [--dotfiles-only]" >&2; exit 1 ;;
esac
[[ $# -le 1 ]] || { echo "Too many arguments" >&2; exit 1; }
OS=$(uname -s)
case "$OS" in Darwin|Linux) ;; *) echo "Unsupported OS: $OS" >&2; exit 1 ;; esac

link_file() {
    local src="$DIR/$1" dest="$HOME/$2"
    if [[ -L "$dest" && $(readlink "$dest") == "$src" ]]; then
        return
    fi
    if [[ -e "$dest" || -L "$dest" ]]; then
        mkdir -p "$BACKUP/$(dirname "$2")"
        mv "$dest" "$BACKUP/$2"
        echo "Backed up $dest to $BACKUP/$2"
    fi
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "Installed $dest"
}

# Explicit list: documentation and setup scripts must never become dotfiles.
for file in tool-versions default-npm-packages ctags gitconfig gitignore tmux.conf zshrc zshrc.darwin zshrc.linux; do
    link_file "$file" ".$file"
done
for file in "$DIR"/config/*; do
    link_file "config/$(basename "$file")" ".config/$(basename "$file")"
done
for file in "$DIR"/local/bin/*; do
    link_file "local/bin/$(basename "$file")" ".local/bin/$(basename "$file")"
done
link_file claude/settings.json .claude/settings.json

if [[ "$OS" == Linux ]]; then
    for file in Xresources gtkrc-2.0 xinitrc i3; do
        link_file "$file" ".$file"
    done
fi

[[ "$DOTFILES_ONLY" == 0 ]] || exit 0
export PATH="$HOME/.local/bin:$PATH"

case "$OS" in
    Darwin)
        # macOS ONLY: Homebrew owns apps; defaults owns system preferences.
        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        else
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            if [[ -x /opt/homebrew/bin/brew ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            else
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi
        # Docker may prompt for sudo; Xcode/mas may need App Store sign-in.
        # Retry after completing those prompts. Do not upgrade installed apps.
        brew bundle install --no-upgrade --file="$DIR/Brewfile"
        "$DIR/macos/setup.sh"
        ;;
    Linux)
        # Linux ONLY: native distro packages. Never Homebrew.
        if command -v pacman >/dev/null; then
            packages=()
            for package in git zsh neovim tmux autoconf \
                gnupg ripgrep direnv github-cli ffmpeg imagemagick jq fd fzf \
                curl unzip base-devel go tree-sitter-cli; do
                if ! pacman -Q "$package" >/dev/null 2>&1; then
                    packages+=("$package")
                fi
            done
            if [[ ${#packages[@]} -gt 0 ]]; then
                sudo pacman -S --needed --noconfirm "${packages[@]}"
            fi
        elif command -v apt-get >/dev/null; then
            # Older distro releases may ship Neovim below 0.12 or omit
            # tree-sitter-cli (0.26.1+ needed). Use newer distro packages there.
            packages=()
            for package in git zsh neovim tmux autoconf gnupg ripgrep direnv gh \
                ffmpeg imagemagick jq fd-find fzf curl unzip build-essential golang-go; do
                if [[ $(dpkg-query -W -f='${Status}' "$package" 2>/dev/null || true) != 'install ok installed' ]]; then
                    packages+=("$package")
                fi
            done
            if [[ ${#packages[@]} -gt 0 ]]; then
                sudo apt-get update
                sudo apt-get install -y "${packages[@]}"
            fi
        else
            echo 'Unsupported Linux package manager; dotfiles installed. Install dependencies with your distro package manager.' >&2
            exit 1
        fi
        # asdf is not packaged by every distro; use its official Go install.
        if ! command -v asdf >/dev/null; then
            GOBIN="$HOME/.local/bin" go install github.com/asdf-vm/asdf/cmd/asdf@v0.20.2
        fi
        ;;
esac

# Shared macOS/Linux runtime setup. Project .tool-versions files stay untouched.
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
while read -r plugin repository; do
    if ! asdf plugin list | grep -qx "$plugin"; then
        asdf plugin add "$plugin" "$repository"
    fi
done <<'PLUGINS'
nodejs https://github.com/asdf-vm/asdf-nodejs.git
rust https://github.com/code-lever/asdf-rust.git
java https://github.com/halcyon/asdf-java.git
android-sdk https://github.com/mise-plugins/mise-android-sdk.git
PLUGINS

# Pin the home LTS deliberately; never resolve "latest" or rewrite project pins
# on a rerun. npm globals belong to each Node install, not to the whole machine.
node_version=$(awk '$1 == "nodejs" {print $2}' "$DIR/tool-versions")
asdf install nodejs "$node_version"
export ASDF_NODEJS_VERSION="$node_version"
while read -r package; do
    case "$package" in ''|\#*) continue ;; esac
    if ! npm list --global --depth=0 "$package" >/dev/null 2>&1; then
        npm install --global "$package"
    fi
done < "$DIR/default-npm-packages"
# agent-browser comes from Brew on macOS, npm on Linux.
if [[ "$OS" == Linux ]] && ! npm list --global --depth=0 agent-browser >/dev/null 2>&1; then
    npm install --global agent-browser --allow-scripts=agent-browser
fi
asdf reshim nodejs "$node_version"
agent-browser install

# Credentials stay outside this public repo (~/.ssh, ~/.gitconfig.local, keychain).
# Account authentication, Xcode licenses and simulator selection require the user.
echo 'Setup complete. Open a new shell. Account logins and Xcode first launch are interactive.'
