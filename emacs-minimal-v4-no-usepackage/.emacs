(add-to-list 'load-path "/home/yaslam/.emacs.d/site-lisp")

(menu-bar-mode 0)
(tool-bar-mode 0)

(global-display-line-numbers-mode 1)
(setq inhibit-startup-message t)

(load-theme 'deeper-blue)

;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(95 95))
(add-to-list 'default-frame-alist '(alpha 95 95))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(general projectile bufler evil-collection pass password-store parinfer-rust-mode magit evil corfu orderless vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(corfu-default ((t (:background "midnight blue"))))
 '(line-number-current-line ((t (:inherit line-number :background "gray16" :foreground "yellow" :weight bold))))
 '(mode-line ((t (:background "gray75" :foreground "black" :box (:line-width (1 . 1) :style released-button))))))

(require 'ffap)
(ffap-bindings)

(require 'vertico)
(vertico-mode 1)

(require 'vertico-directory)
(keymap-set vertico-map "RET" #'vertico-directory-enter)
(keymap-set vertico-map "DEL" #'vertico-directory-delete-char)
(keymap-set vertico-map "M-DEL" #'vertico-directory-delete-word)
(add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy)

(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

(require 'corfu)
(global-corfu-mode 1)
(setq tab-always-indent 'complete)

(setq evil-want-keybinding 'nil)
(require 'evil)
(evil-mode 1)

(evil-define-key 'normal global-map
  "gc" 'comment-line)

(require 'evil-collection)
(evil-collection-init)

(require 'magit)
(global-set-key (kbd "C-x g") 'magit)

(require 'parinfer-rust-mode)
(add-hook 'emacs-lisp-mode-hook 'parinfer-rust-mode)

(require 'ysz-bufler-config)
(global-set-key (kbd "C-c b") 'bufler-switch-buffer)
(global-set-key (kbd "C-c C-S-b") 'bufler-list)

(evil-define-key 'normal bufler-list-mode-map
 "K" 'bufler-list-buffer-kill
 "gs" 'bufler-list-buffer-save
 "q" 'quit-window
 (kbd "RET") 'bufler-list-buffer-switch
 "n" 'magit-section-forward-sibling
 "p" 'magit-section-backward-sibling
 (kbd "TAB") 'magit-section-toggle
 (kbd "?") 'hydra:bufler/body
 "f" 'bufler-list-group-frame
 "F" 'bufler-list-group-make-frame)

(bufler-mode 1)

(require 'ysz-keybinds)
