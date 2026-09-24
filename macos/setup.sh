#!/bin/bash
set -euo pipefail
[[ $(uname -s) == Darwin ]] || { echo 'macOS only' >&2; exit 1; }

# 300 ms before repeating, then 15 ms between repeats. A 75 ms initial delay
# produced accidental repeats during ordinary taps; keep delay and speed separate.
defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1
defaults write -g ApplePressAndHoldEnabled -bool false

# Retire the old polling workaround from this repository.
agent="$HOME/Library/LaunchAgents/com.boudra.keyboard.plist"
if [[ -e "$agent" ]]; then
    launchctl bootout "gui/$(id -u)/com.boudra.keyboard" 2>/dev/null || true
    mkdir -p "$HOME/.dotfiles-backup"
    mv "$agent" "$HOME/.dotfiles-backup/keyboard-polling-$(date +%Y%m%d-%H%M%S).plist"
    hidutil property --set '{"UserKeyMapping":[]}' >/dev/null
fi

# Same per-keyboard preference as System Settings > Keyboard > Modifier Keys.
# Preserve other modifier mappings; replace only Caps Lock. Reload at next login.
# New keyboards have different IDs: rerun setup after connecting them.
/usr/bin/ruby <<'RUBY'
require 'json'
require 'open3'
output, status = Open3.capture2('hidutil', 'list', '--matching', 'keyboard')
abort 'Cannot enumerate keyboards' unless status.success?
keyboards = output.lines.filter { |l| l.match(/^0x[0-9a-f]+\s+0x[0-9a-f]+/i) }
                 .map { |l| l.split.first(2).map { |v| Integer(v) } }.uniq
abort 'No keyboard found; connect one and rerun setup' if keyboards.empty?
keyboards.each do |vendor, product|
  key = "com.apple.keyboard.modifiermapping.#{vendor}-#{product}-0"
  old, _, status = Open3.capture3('defaults', '-currentHost', 'read', '-g', key)
  mappings = []
  if status.success?
    json, _, converted = Open3.capture3('plutil', '-convert', 'json', '-o', '-', '-', stdin_data: old)
    abort "Cannot read #{key}" unless converted.success?
    mappings = JSON.parse(json)
  end
  mappings.reject! { |m| [0, 30064771129].include?(m['HIDKeyboardModifierMappingSrc'].to_i) }
  mappings << { 'HIDKeyboardModifierMappingSrc' => 30064771129, 'HIDKeyboardModifierMappingDst' => 30064771296 }
  entries = mappings.map do |m|
    '<dict>' + m.map { |k,v| "<key>#{k}</key><integer>#{Integer(v)}</integer>" }.join + '</dict>'
  end
  abort 'Cannot save modifier mapping' unless system('defaults', '-currentHost', 'write', '-g', key, '-array', *entries)
end
RUBY

# Opaque dark menu bar instead of wallpaper tint. Some macOS versions protect
# this accessibility preference from defaults, requiring the System Settings UI.
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'
if [[ $(defaults read com.apple.universalaccess reduceTransparency 2>/dev/null || true) != 1 ]]; then
    if ! defaults write com.apple.universalaccess reduceTransparency -bool true 2>/dev/null; then
        echo 'Enable System Settings > Accessibility > Display > Reduce transparency (macOS protects this setting).' >&2
    fi
fi

# Empty Dock, keeping running apps/Finder/Trash. Back up its original state once.
mkdir -p "$HOME/.dotfiles-backup"
if [[ ! -e "$HOME/.dotfiles-backup/dock-before-cleanup.plist" ]]; then
    defaults export com.apple.dock "$HOME/.dotfiles-backup/dock-before-cleanup.plist"
fi
changed=0
for key in persistent-apps persistent-others; do
    if defaults read com.apple.dock "$key" 2>/dev/null | grep -q 'tile-data'; then
        defaults write com.apple.dock "$key" -array
        changed=1
    fi
done
if [[ $(defaults read com.apple.dock show-recents 2>/dev/null || true) != 0 ]]; then
    defaults write com.apple.dock show-recents -bool false
    changed=1
fi
[[ "$changed" == 0 ]] || killall Dock

# Both apps registered login helpers at first launch on the fresh Mac.
for helper in com.docker.helper com.spotify.client.startuphelper; do
    launchctl disable "gui/$(id -u)/$helper"
    launchctl bootout "gui/$(id -u)/$helper" 2>/dev/null || true
done
echo 'macOS preferences applied. Log out/in for keyboard settings to fully reload.'
