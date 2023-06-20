#!/bin/bash

DOTFILES="$HOME/.dotfiles"

cd $DOTFILES
echo -e "\n[Linked files]"
find $HOME -type l | xargs readlink -- | grep -i "\.dotfiles" | sed 's/\.\.\///1' | sed 's/.dotfiles\///g' | sort

echo -e "\n[Select packages to UN-install]"

PACKAGES_LIST=()

select SELECTION in $(find $HOME -type l | xargs readlink -- | grep -i dotfiles | sed 's/\.\.\///1' | sed 's/.dotfiles\///g' | sed 's/\/.*//g' | sort -u | sort && echo -e "[EXIT]")
do
	[[ $SELECTION == "[EXIT]" ]] && break
	PACKAGES_LIST+=($SELECTION)
	echo "Selected: ${PACKAGES_LIST[@]}"
done

for PACKAGE in ${PACKAGES_LIST[@]}
do
	printf "\nUnlinking %s from $HOME\n" "$PACKAGE"
	stow -D "$PACKAGE" -t "$HOME" -v
done
