;;; Misc. tweaks --- ysz-tweaks.el
;;; ../.dotfiles/doom-emacs-v2/.doom.d/lisp/ysz-addons/ysz-tweaks.el -*- lexical-binding: t; -*-

(defun ysz/get-doom-doc-buffer-p ()
  "Check if the current buffer is a Doom documentation buffer, return `t' if so, else `nil'."
  (when buffer-file-name
    (string-match "/.emacs.d/doc" buffer-file-name)))

(defun ysz/get-doom-module-doc-buffer-p ()
  "Check if the current buffer is a Doom module documentation buffer, return `t' if so, else `nil'."
 (when buffer-file-name
  (string-match "/.emacs.d/modules/tools/" buffer-file-name)))

(defun ysz/get-doom-config-buffer-p ()
  "Check if the current buffer has a file name corresponding to the Doom Emacs
configuration file directory, if so return `t', else return `nil'."
  (and (derived-mode-p 'prog-mode)
       (when buffer-file-name
         (string-match ".doom.d" buffer-file-name))))

(defun ysz/get-emacs-doc-buffer-p ()
  "Check if the current buffer major mode or name corresponds to an Info
buffer, if so, return `t', else return `nil'."
  (or (memq major-mode '(Info-mode))
      (string-match "*Info" (buffer-name))))

(defun centaur-tabs-buffer-groups ()
  "`centaur-tabs-buffer-groups' control buffers' group rules.

Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
All buffer names that start with * but not having the `mu4e-headers' major mode will group to \"Emacs\".
Other buffer group by `centaur-tabs-get-group-name' with project name."
  (list
   (cond
    ((ysz/get-emacs-doc-buffer-p)
     "Emacs Docs")
    ((and (string-equal "*" (substring (buffer-name) 0 1))
          (not (memq major-mode '(mu4e-main-mode
                                  mu4e-headers-mode
                                  mu4e-view-mode
                                  mu4e-compose-mode
                                  erc-mode))))
     "Emacs")
    ((memq major-mode '(magit-process-mode
                        magit-status-mode
                        magit-diff-mode
                        magit-log-mode
                        magit-file-mode
                        magit-blob-mode
                        magit-blame-mode))
     "Git")
    ((ysz/get-doom-config-buffer-p)
     "Doom Emacs Configuration")
    ((and (derived-mode-p 'prog-mode)
          (not (ysz/get-doom-config-buffer-p)))
     "Editing")
    ((derived-mode-p 'dired-mode)
     "Dired")
    ((memq major-mode '(helpful-mode
                        help-mode))
     "Help")
    ((memq major-mode '(org-mode
                        org-agenda-clockreport-mode
                        org-src-mode
                        org-agenda-mode
                        org-beamer-mode
                        org-indent-mode
                        org-bullets-mode
                        org-cdlatex-mode
                        org-agenda-log-mode
                        diary-mode))
     "OrgMode")
    ((memq major-mode '(mu4e-main-mode
                        mu4e-headers-mode
                        mu4e-compose-mode
                        mu4e-view-mode))
     "Mail")
    ((memq major-mode '(erc-mode))
     "IRC")
    ((ysz/get-doom-doc-buffer-p)
     "Doom Emacs Docs")
    ((ysz/get-doom-module-doc-buffer-p)
     "Doom Emacs Module Docs")
    (t
     (centaur-tabs-get-group-name (current-buffer))))))

(provide 'ysz-tweaks)
