dir=~/dotfiles

exclude=("install.sh", ".git", ".gitignore")

cd $dir

for file in  *; do
    for ((i = 0; i < ${#exclude[@]}; i++)); do
        if [[ ${file} != ${exclude[${index}]} ]]; then
            rm -rf ~/.${file}
            ln -s ${dir}/${file} ~/.${file}
        fi
    done
done

gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing rgba
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting slight

gsettings set org.gnome.desktop.interface document-font-name "PT Sans 11"
gsettings set org.gnome.desktop.interface font-name "PT Sans 11"
gsettings set org.gnome.desktop.interface monospace-font-name "Inconsolata
Medium 11"
