#!/bin/bash

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


${DIR}/fzf/install

GLOBAL_OVERWRITE=0

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

    if [ $NAME == "gitconfig" ]; then
        read -r -p "Please specify the author email address to use for git: " EMAIL
        read -r -p "Please specify the author name to use for git (usually your full name): " NAME
        rm -rf ${DEST}
        cp ${SRC} ${DEST}
        sed -i '' "s/{{\ EMAIL\ }}/$EMAIL/" ${DEST}
        sed -i '' "s/{{\ NAME\ }}/$NAME/" ${DEST}
        continue
    fi

    mkdir -p $(dirname $DEST)
    rm -rf ${DEST}
    ln -s ${SRC} ${DEST}

    echo "$DEST installed."

done

curl https://git.io/fisher --create-dirs -sLo ${DIR}/config/fish/functions/fisher.fish
fish -c fisher

curl -sfL https://direnv.net/install.sh | bash
