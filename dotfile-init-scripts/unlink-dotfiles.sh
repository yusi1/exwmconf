#!/usr/bin/env bash

DOTFILES_REPO="git@git.sr.ht:~yusz/dotfiles-v2"
DOTFILES="$HOME/.dotfiles"

if [[ $(which git 2>/dev/null) ]]; then
	[ ! -d $DOTFILES ] && git clone $DOTFILES_REPO $DOTFILES
else
	echo "git not found, exiting."
fi

[[ $(which stow 2>/dev/null) ]] || echo "stow not found, exiting."

cd $DOTFILES
echo -e "\n[Linked files]"
find $HOME -type l | xargs readlink -- | grep -i "\.dotfiles" | sed 's/\.\.\///1' | sed 's/.dotfiles\///g' | sort

echo -e "\n[Select packages to UN-install]"

PACKAGES_LIST=()

select SELECTION in $(echo "[EXIT]" && find $HOME -type l | xargs readlink -- | grep -i dotfiles | sed 's/\.\.\///1' | sed 's/.dotfiles\///g' | sed 's/\/.*//g' | sort -u | sort)
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
