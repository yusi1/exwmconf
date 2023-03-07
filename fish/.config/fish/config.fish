if status is-interactive
    xrdb -merge ~/.Xresources

    # global exported variables
    set -gx EDITOR nvim
    set -gx PAGER nvimpager

    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
    dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY

    # onedark theme stuff
    # set -l onedark_options '-b'

    # if set -q VIM
    #     # Using from vim/neovim.
    #     set onedark_options "-256"
    # else if string match -iq "eterm*" $TERM
    #     # Using from emacs.
    #     function fish_title; true; end
    #     set onedark_options "-256"
    # end

    # set_onedark $onedark_options
end
