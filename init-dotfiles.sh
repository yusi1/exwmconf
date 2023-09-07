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
echo -e "\n[Select packages to install]"

PACKAGES_LIST=()

select SELECTION in $(echo "[EXIT]" && find . -maxdepth 1 | sed 's/\.\///1' | sort | awk 'NR>1')
do
	[[ $SELECTION == "[EXIT]" ]] && break
	PACKAGES_LIST+=($SELECTION)
	echo "Selected: ${PACKAGES_LIST[@]}"
done

for PACKAGE in ${PACKAGES_LIST[@]}
do
	printf "\nLinking %s into $HOME\n" "$PACKAGE"
	stow -S "$PACKAGE" -t "$HOME" -v
done
