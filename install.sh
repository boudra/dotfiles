#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )

FILES=$( find $DIR/* $DIR/config/* -maxdepth 0 \
    -not -name 'install.sh' \
    -not -name '.git' \
    -not -name 'README.md' \
    -not -name '.gitignore' \
    -not -name '.gitmodules' \
    -not -name 'config' \
    -not -path .
)

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Setting up keyboard repeat rate ..."

    defaults write -g InitialKeyRepeat -int 10
    defaults write -g KeyRepeat -int 1
fi

git -C ${DIR} submodule update --init --recursive

GLOBAL_OVERWRITE=1

while getopts "f" o; do
    case "${o}" in
        f)
            GLOBAL_OVERWRITE=1
            ;;
    esac
done
shift $((OPTIND-1))

for FILE in $FILES; do

    FILE=$(echo $FILE | sed "s!^$DIR/!!")

    NAME=$(basename $FILE)
    DEST=$HOME/.$FILE
    SRC=${DIR}/${FILE}
    OVERWRITE=$GLOBAL_OVERWRITE

    echo "Installing $SRC to $DEST ..."

    if [ -e $DEST ]; then

        if [ $OVERWRITE -eq 0 ]; then
            read -r -p "\`$DEST' already exists. Do you want to overwrite it?  [y/N] " RESPONSE
            if ! [[ $RESPONSE =~ ^([yY][eE][sS]|[yY])$  ]]; then
                continue
            fi
        fi

    fi

    mkdir -p $(dirname $DEST)
    rm -rf ${DEST}
    ln -s ${SRC} ${DEST}

    echo "$DEST installed."

done
