# My Dotfiles for Emacs and other utilities

## Test the process with:

`stow --dotfiles --simulate -v -t "$HOME" -S <package name>`

## Then, do the real thing if the test succeeded:

`stow --dotfiles -v -t "$HOME" -S <package name>`

## If symlinks are broken, restow with:

### Do the test first:

`stow --dotfiles -v --simulate -v -t "$HOME" -R <package name>`

### Then, do the proper thing:

`stow --dotfiles -v -t "$HOME" -R <package name>`

## DISCLAIMER:

Before stowing, make sure existing directories in the home directory are deleted or backed up.
