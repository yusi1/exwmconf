(add-to-list 'load-path (concat (expand-file-name user-emacs-directory) "ysz-addons"))
(add-to-list 'load-path (concat (expand-file-name user-emacs-directory) "site-lisp"))
(setq custom-theme-directory (concat (expand-file-name user-emacs-directory) "ysz-themes"))

(load-theme 'ysz-dark t)

(require 'ysz-custom)
(require 'ysz-ui)

;; send `kill-ring' and `kill-ring-save' functions to the system clipboard.
(require 'osc52)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq straight-use-package-by-default nil)
(setq package-enable-at-startup nil)
(straight-use-package 'use-package)
(setq use-package-enable-imenu-support t)
(require 'straight-x)
(if init-file-debug
    (setq use-package-verbose t
          use-package-expand-minimally nil
          use-package-compute-statistics t
          debug-on-error t)
  (setq use-package-verbose nil
        use-package-expand-minimally t))

;; enabled commands
(put 'downcase-region 'disabled nil)
(put 'emms-browser-delete-files 'disabled nil)

(use-package ysz-theme)
(use-package ysz-keybinds)
(use-package ysz-completion)
(use-package ysz-lang-helpers)
(use-package ysz-irc)
