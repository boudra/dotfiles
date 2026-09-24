# Personal dotfiles

- These are personal dotfiles. Preserve the owner's preferences and workflows.
- Everything must work on both macOS and Linux. Guard platform-specific behavior and tolerate missing optional tools.
- This repository is public. Never commit or publish secrets, credentials, or sensitive information. Keep them outside the repo and check diffs before publishing. Use placeholders for emails and personal details, even if already public elsewhere.
- Keep platform branches explicit: Homebrew/Brewfile on macOS, native distro packages on Linux. Never use Homebrew on Linux. Keep setup in install.sh and documentation short.
- Keep installation safe to rerun and preserve existing user files.
- Automate setup in scripts; put useful gotchas and their reasons in code comments, not separate setup notes.
