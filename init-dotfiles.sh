#!/bin/bash

DOTFILES_REPO="git@git.sr.ht:~yusz/dotfiles-v2"
DOTFILES="$HOME/.dotfiles"

[[ $(which apt 2>/dev/null) ]] && PKGMGR="apt" DISTRO="ubuntu/debian"
[[ $(which xbps-install 2>/dev/null) ]] && PKGMGR="xbps" DISTRO="void"
[[ $(which pacman 2>/dev/null) ]] && PKGMGR="pacman" DISTRO="arch"

case $DISTRO in
	"ubuntu/debian")
		INSTALLCMD="sudo apt install ";;
	"void")
		INSTALLCMD="sudo xbps-install -S ";;
	"arch")
		INSTALLCMD="sudo pacman -S ";;
esac

if [[ $(which git 2>/dev/null) ]]; then
	[ ! -d $DOTFILES ] && git clone $DOTFILES_REPO $DOTFILES
else
	echo "git not found, installing using $PKGMGR"
	echo $(${INSTALLCMD} "git")
fi

[[ $(which stow 2>/dev/null) ]] || echo $(${INSTALLCMD} "stow")
[[ $(which dialog 2>/dev/null) ]] || echo $(${INSTALLCMD} "dialog")

cd $DOTFILES
echo -e "\n[Select packages to install]"

PACKAGES_LIST=()

select SELECTION in $(find . -maxdepth 1 | sed 's/\.\///1' | sort | awk 'NR>1' && echo -e "\n[EXIT]")
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
