#!/usr/bin/emacs --script

(with-temp-buffer
    (find-file "~/.config/nvim/init.vim")
    (beginning-of-buffer)
    (if (search-forward-regexp "colorscheme solarized" nil t)
        (progn
            (forward-word 2)
            (backward-delete-char (length "solarized"))
            (insert "default")
            ;; (save-buffer)
            (kill-this-buffer))
      (progn (beginning-of-buffer)
             (search-forward-regexp "colorscheme default" nil t)
             (forward-word 2)
             (backward-delete-char (length "default"))
             (insert "solarized")
             ;; (save-buffer)
             (kill-this-buffer))))
