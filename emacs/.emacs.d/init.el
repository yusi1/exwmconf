(server-start)

;; (set-frame-parameter (selected-frame) 'alpha-background 85)
;; (add-to-list 'default-frame-alist '(alpha-background . 85))

;; (modify-all-frames-parameters '((width . 95)
;; 				(height . 25)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(custom-safe-themes
   '("066571805262571596daa4b1f4da937e8ad68cb36b303afa4008791f9af7a1d9" "9912d4f8e31ebf8fe2fd18980e9b90749761cf21e25882967b55791bcd4496d2" "fee7287586b17efbfda432f05539b58e86e059e78006ce9237b8732fde991b4c" "2eb727f27111abbc9c604bd4175e9ca4a45bc5a56f11128244d3811aa8959586" "40a098fc12ff7ec6625c81bfd859106794c2598daaa07595f61e3836ed06562c" "1a9af4aecdccf2b3e5af0687f97cc7ae1662572957a3085b7c4ce54b7af0de1b" "2ed330854b511e6305791e0b3b9b41ac67283caf47a45e7670e6044a4d35f12c" "ace833d28feae75375ec30faf173e0fd7b5b485c3bbf303fb1f4145f0817a0b1" "3030b399c81237c6dd1e48859af6793849a87268e234184299a6ef0eb83065c3" "168c2d01105a4675a6ba190c897a7df397b0310b8ef3af364e2c671986024594" "5effb2f2bf751bebbbd67c18aa205828fc93c2c7fee49793bd68be9271d4adc2" "a5e52e1d185bdcfbb77fac55abca7ec73a66064023172e0640326b2e5191067b" "97549a448b9ccc6869ca36d49b4b26ebc1a0addff5df4487271f00f17c6e7833" "67c9551f7d89cef61dcb1c80692e7efdb9d773837354f996a4b89c0c267b8760" "02945b299acfa2fd8a30641707f74de8e3030301105c90d8892f0077cde41317" "fcef410973e8054473a6bd198a46326864b68a629aff5a2032d385126ab25481" "51d515d2695c334ba9de9f62c1de35e93534eef5c4a3cfd17699713ade9bd6f5" "6debd313d1a32c77bc92a2704d8cec5cc41f4ebb3071137be9201fdf4b5bc9d9" "f144b8fdd4d19287cfb4b6f91598d230f6986bc6cbce9e06a61efbe45edcd490" "a0816d43b51dada126d404e9801cf7796cf030e855748ffebff79b1d46c437d7" "862224fd54f3d20a549e869df1f960d5e9a84459d0ecbcf33ccb2caafbc82d43" "4ff9cceb52d176c491d4b9a65fc149e40df87682b1edac6a43011264a8319f8c" "84bb2ad9d4d861a307171718840d486f5b9f6b9d7af9c0ce00a70b91e8747756" "9724dd370de9086cc2ab6b0c6a563d6b4967d0262187fd6d712e8ce413eea7cd" "ed0fab80b2281894fbe53fb8ba3dad24a2dbbf6be1ddd19f76c97f21cf4c5ac2" "276c229174c67849fabffe2191be30a2663d7ce7a1b05b7e2bf3ddac624136ec" "c282a528137220d5f71c84ca68eb8bd87b3ccb3656434b20ad600a380f9f198c" "7d2734f226168fd7a47ab8fce2dfb4047b1a41f1844bde7eb9b91de461c40029" "c25d00b2b71ebd0133d4512ad6070342dd0b662d30106bbacced82a6c52ade8c" "3c18abfca12fa71b6d4a998d4cfe49e8248620ebb24cdc4992110206e5eb5be5" "28d87ee3d89c7625702cb2596f897528d7f59cc580be5c401757493521b692fc" "7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "0c08a5c3c2a72e3ca806a29302ef942335292a80c2934c1123e8c732bb2ddd77" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" "f64189544da6f16bab285747d04a92bd57c7e7813d8c24c30f382f087d460a33" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "930ebff784a26210a29eeb4513518ec06340fb2afb5863211385aca08b55d18c" default))
 '(smtpmail-smtp-server "outlook.office365.com" t)
 '(smtpmail-smtp-service 25 t))
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
;; (use-package ysz-lang-helpers)
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
