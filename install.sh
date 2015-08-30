#!/bin/bash
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
