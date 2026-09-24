# Personal dotfiles

```sh
git clone https://github.com/boudra/dotfiles ~/dev/dotfiles
~/dev/dotfiles/install.sh
```

Safe to rerun: existing files are backed up, correct links are left alone, and
installed packages are not upgraded. Use `--dotfiles-only` to skip machine setup.

- **macOS:** Homebrew + Brewfile, native keyboard preferences, empty Dock, and
  disabled Docker/Spotify login helpers. No keyboard background service.
- **Linux:** pacman or apt, never Homebrew. Shared dotfiles plus Linux desktop
  configs. Distro package versions apply; Neovim needs 0.12+ and tree-sitter-cli
  0.26.1+ (older distro releases may need newer packages).
- **Both:** asdf, the pinned Node LTS in `tool-versions`, and global npm tools in
  `default-npm-packages`. Project runtime pins remain separate.

Run from a terminal for administrator/App Store prompts. Account sign-ins, SSH
key registration, and Xcode licenses/simulator selection remain interactive.
Rerun after interruptions or connecting a new keyboard; log out/in after keyboard
changes. Keep credentials outside this public repo.
