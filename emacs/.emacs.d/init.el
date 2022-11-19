(server-start)

;; (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 90)))

;; (modify-all-frames-parameters '((width . 95)
;; 				(height . 25)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("84bb2ad9d4d861a307171718840d486f5b9f6b9d7af9c0ce00a70b91e8747756" "9724dd370de9086cc2ab6b0c6a563d6b4967d0262187fd6d712e8ce413eea7cd" "ed0fab80b2281894fbe53fb8ba3dad24a2dbbf6be1ddd19f76c97f21cf4c5ac2" "276c229174c67849fabffe2191be30a2663d7ce7a1b05b7e2bf3ddac624136ec" "c282a528137220d5f71c84ca68eb8bd87b3ccb3656434b20ad600a380f9f198c" "7d2734f226168fd7a47ab8fce2dfb4047b1a41f1844bde7eb9b91de461c40029" "c25d00b2b71ebd0133d4512ad6070342dd0b662d30106bbacced82a6c52ade8c" "3c18abfca12fa71b6d4a998d4cfe49e8248620ebb24cdc4992110206e5eb5be5" "28d87ee3d89c7625702cb2596f897528d7f59cc580be5c401757493521b692fc" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "930ebff784a26210a29eeb4513518ec06340fb2afb5863211385aca08b55d18c" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Packages

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
      (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Always use straight to install on systems other than Linux
(setq straight-use-package-by-default nil)

;; Use straight.el for use-package expressions
(straight-use-package 'use-package)

;; Enable imenu support for use-package expressions
(setq use-package-enable-imenu-support t)

;; Make use-package error debugging more helpful when
;; Emacs is launched with the option `--debug-init'.
(if init-file-debug
    (setq use-package-verbose t
          use-package-expand-minimally nil
          use-package-compute-statistics t
          debug-on-error t)
  (setq use-package-verbose nil
        use-package-expand-minimally t))

;; Load the helper package for commands like
;; `straight-x-clean-unused-repos'
(require 'straight-x)

;; enabled commands
(put 'downcase-region 'disabled nil)
(put 'emms-browser-delete-files 'disabled nil)

(use-package ysz-theme)
(use-package ysz-completion)
(use-package ysz-git)
;; (use-package ysz-email)
(use-package ysz-keybinds)
(use-package ysz-writing)
(use-package ysz-lang)
(use-package ysz-functions)
(use-package ysz-shell)
(use-package ysz-utils)
(use-package ysz-media)
(use-package ysz-irc)

;;; EXWM
(defun ysz/exwm-enabled (switch) "Dummy function")
(add-to-list 'command-switch-alist '("--use-exwm" . ysz/exwm-enabled))
(setq ysz/exwm-enabled-p
      (if (seq-contains command-line-args "--use-exwm") t))

(when ysz/exwm-enabled-p
  (use-package ysz-desktop-init)
  (use-package ysz-desktop))
