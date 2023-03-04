(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))
(add-to-list 'load-path (concat user-emacs-directory "ysz-addons"))
(add-to-list 'load-path "~/Git/parinfer-rust-mode")

(setq inhibit-startup-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-collection corfu standard-themes bufler dash pulsar evil vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight regular :height 143 :width normal :foundry nil :family "DejaVu Sans Mono")))))

(add-to-list 'default-frame-alist '(width  . 80))
(add-to-list 'default-frame-alist '(height . 20))

(pixel-scroll-precision-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(ffap-bindings)

;; (load-theme 'modus-operandi t)
;; (defun my-modus-themes-custom-faces ()
;;     (modus-themes-with-colors
;;         (custom-set-faces
;;         ;; Add "padding" to the mode lines
;;          `(mode-line ((,c :box (:line-width 4 :color ,bg-mode-line-active))))
;;          `(mode-line-inactive ((,c :box (:line-width 4 :color ,bg-mode-line-inactive)))))))

;; (add-hook 'modus-themes-after-load-theme-hook #'my-modus-themes-custom-faces)

;; copy kills/yanks to system clipboard
(require 'osc52)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(require 'standard-themes)

;; Read the doc string of each of those user options.  These are some
;; sample values.
(setq standard-themes-bold-constructs t
      standard-themes-italic-constructs t
      standard-themes-mixed-fonts nil
      standard-themes-variable-pitch-ui nil
      standard-themes-mode-line-accented nil

      ;; Accepts a symbol value:
      standard-themes-fringes 'subtle

      ;; The following accept lists of properties
      standard-themes-links '(neutral-underline)
      standard-themes-region '(no-extend neutral intense)
      standard-themes-prompts '(bold italic)

      ;; more complex alist to set weight, height, and optional
      ;; `variable-pitch' per heading level (t is for any level not
      ;; specified):
      standard-themes-headings
      '((0 . (light 1.3))
        (1 . (light 1.2))
        (2 . (light 1.1))
        (3 . (semilight 1.08))
        (4 . (semilight 1.06))
        (5 . (1.04))
        (6 . (1.02))
        (7 . (1.0))
        (t . (1.0))))

;; Disable all other themes to avoid awkward blending:
(mapc #'disable-theme custom-enabled-themes)

(load-theme 'standard-light :no-confirm)
(keymap-set global-map "<f12>" #'standard-themes-toggle)

(require 'orderless)
(setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion))))

(require 'vertico)
(vertico-mode 1)
(require 'vertico-directory)
(progn
  (keymap-set vertico-map "RET" #'vertico-directory-enter)
  (keymap-set vertico-map "DEL" #'vertico-directory-delete-char)
  (keymap-set vertico-map "M-DEL" #'vertico-directory-delete-word)
  (add-hook 'rfn-eshadow-update-overlay-hook #'vertico-directory-tidy))

(setq evil-want-keybinding nil)
(require 'evil)
(evil-define-key 'visual global-map "gc" 'comment-dwim)
(evil-define-key 'normal global-map "gcc" 'comment-line)

(evil-define-key 'normal bufler-list-mode-map
  "K" 'bufler-list-buffer-kill
  "q" 'quit-window
  (kbd "RET") 'bufler-list-buffer-switch
  "n" 'magit-section-forward-sibling
  "p" 'magit-section-backward-sibling
  (kbd "TAB") 'magit-section-toggle
  (kbd "?") 'hydra:bufler/body)

(evil-mode 1)

(require 'evil-collection)
(evil-collection-init '(magit ibuffer help))

(require 'pulsar)
(setq pulsar-pulse-functions '(recenter-top-bottom move-to-window-line-top-bottom reposition-window bookmark-jump other-window delete-window delete-other-windows forward-page backward-page scroll-up-command scroll-down-command windmove-right windmove-left windmove-up windmove-down windmove-swap-states-right windmove-swap-states-left windmove-swap-states-up windmove-swap-states-down tab-new tab-close tab-next org-next-visible-heading org-previous-visible-heading org-forward-heading-same-level org-backward-heading-same-level outline-backward-same-level outline-forward-same-level outline-next-visible-heading outline-previous-visible-heading outline-up-heading kill-line evil-delete-line evil-delete))
(pulsar-global-mode 1)

(require 'parinfer-rust-mode)
(add-hook 'emacs-lisp-mode-hook 'parinfer-rust-mode)

(require 'bufler)
(require 'ysz-bufler-config)
(bufler-mode 1)
;; (bufler-tabs-mode 1)
(keymap-set global-map "C-c b" 'bufler-switch-buffer)
(keymap-set global-map "C-c C-S-b" 'bufler-list)

(require 'corfu)
(global-corfu-mode 1)
;; Enable auto completion and configure quitting
(setq corfu-auto t
      corfu-quit-no-match 'separator) ;; or t

(require 'corfu-popupinfo)
(corfu-popupinfo-mode 1)
(keymap-set corfu-map "M-d" 'corfu-popupinfo-toggle)

(require 'emacs)
;; TAB cycle if there are only few candidates
(setq completion-cycle-threshold 3)

;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
;; Corfu commands are hidden, since they are not supposed to be used via M-x.
;; (setq read-extended-command-predicate
;;       #'command-completion-default-include-p)

;; Enable indentation+completion using the TAB key.
;; `completion-at-point' is often bound to M-TAB.
(setq tab-always-indent 'complete)
