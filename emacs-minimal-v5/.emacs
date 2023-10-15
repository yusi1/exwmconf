(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "51c71bb27bdab69b505d9bf71c99864051b37ac3de531d91fdad1598ad247138" "7e068da4ba88162324d9773ec066d93c447c76e9f4ae711ddd0c5d3863489c52" "a589c43f8dd8761075a2d6b8d069fc985660e731ae26f6eddef7068fece8a414" "a138ec18a6b926ea9d66e61aac28f5ce99739cf38566876dc31e29ec8757f6e2" "da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738" "dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "8b930a6af47e826c12be96de5c28f1d142dccab1927f196589dafffad0fc9652" "8f663b8939be3b54d70a4c963d5d0f1cfd278f447cb4257df6c4571fb8c71bca" default))
 '(keycast-header-line-remove-tail-elements nil)
 '(keycast-mode-line-remove-tail-elements nil)
 '(minimap-minimum-width 15)
 '(minimap-width-fraction 0.08)
 '(minimap-window-location 'right)
 '(package-selected-packages
   '(mines orderless vertico all-the-icons material-theme mini-frame sublime-themes org-superstar 2048-game tabnine doom-themes standard-themes simple-modeline highlight-leading-spaces keycast dirvish color-identifiers-mode anzu helm-migemo migemo helm-swoop corfu minimap volatile-highlights beacon cursory keepass-mode helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:slant normal :weight normal :height 140 :width normal :foundry "GOOG" :family "Roboto Mono"))))
 ;; '(minimap-active-region-background ((t (:extend t :background "#22262E"))))
 '(mode-line ((t (:height 140))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono" :height 2.0 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#ECEFF4" :family "Roboto Mono")))))

;; (require 'nano)
;; (setq nano-font-size 14)
;; (setq nano-font-family-proportional nil)

;; (require 'nano-theme-dark)
;; (nano-toggle-theme)

;; (require 'nano-writer)

;; (require 'nano-minibuffer)

(setq initial-frame-alist
      '((top . 1) (left . 1) (width . 69) (height . 32)))

(setq inhibit-startup-screen t)

(setq modus-themes-mode-line '(3d))

(load-theme 'modus-operandi t)
(global-display-line-numbers-mode 1)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; CUA mode is a global minor mode.  When enabled, typed text
;; replaces the active selection, and you can use C-z, C-x, C-c, and
;; C-v to undo, cut, copy, and paste in addition to the normal Emacs
;; bindings.  The C-x and C-c keys only do cut and copy when the
;; region is active, so in most cases, they do not conflict with the
;; normal function of these prefix keys.
(cua-mode 1)

;; Find-file-at-point bindings
(ffap-bindings)

;; Delete selection
(delete-selection-mode 1)

;; VC follow symlinks
(setq vc-follow-symlinks t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(package-initialize)

;; (require 'vertico)
;; (vertico-mode 1)

;; ;; Not needed with helm
;; (require 'orderless)
;; (setq completion-styles '(orderless basic)
;;       completion-category-overrides '((file (styles basic partial-completion))))

(require 'helm)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-s o") 'helm-occur)
(helm-mode 1)

;; helm from https://github.com/emacs-helm/helm
(require 'helm)

;; Locate the helm-swoop folder to your path
(add-to-list 'load-path "~/.emacs.d/elisp/helm-swoop")
(require 'helm-swoop)
(require 'migemo)

;; Change the keybinds to whatever you like :)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
(define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

;; Move up and down like isearch
(define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
(define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
(define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)

;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; ;; Go to the opposite side of line from the end or beginning of line
(setq helm-swoop-move-to-line-cycle t)

;; Optional face for line numbers
;; Face name is `helm-swoop-line-number-face`
(setq helm-swoop-use-line-number-face t)

;; If you prefer fuzzy matching
(setq helm-swoop-use-fuzzy-match t)

;; If you would like to use migemo, enable helm's migemo feature
(helm-migemo-mode 1)


(require 'cursory)

;; Check the `cursory-presets' for how to set your own preset styles.

(setq cursory-latest-state-file (locate-user-emacs-file "cursory-latest-state"))

;; Set last preset or fall back to desired style from `cursory-presets'.
(cursory-set-preset (or (cursory-restore-latest-preset) 'bar))

;; The other side of `cursory-restore-latest-preset'.
(add-hook 'kill-emacs-hook #'cursory-store-latest-preset)

;; We have to use the "point" mnemonic, because C-c c is often the
;; suggested binding for `org-capture'.
(define-key global-map (kbd "C-c p") #'cursory-set-preset)

(require 'beacon)
(beacon-mode 1)

(require 'volatile-highlights)
(volatile-highlights-mode t)

(require 'minimap)
(minimap-mode 1)

(require 'corfu)
(global-corfu-mode 1)

;; TAB cycle if there are only few candidates
(setq completion-cycle-threshold 3)

;; Emacs 28: Hide commands in M-x which do not apply to the current mode.
;; Corfu commands are hidden, since they are not supposed to be used via M-x.
;; (setq read-extended-command-predicate
;;       #'command-completion-default-include-p)

;; Enable indentation+completion using the TAB key.
;; `completion-at-point' is often bound to M-TAB.
(setq tab-always-indent 'complete)


(require 'anzu)
(global-anzu-mode +1)

(require 'dirvish)
(dirvish-override-dired-mode 1)

(require 'keycast)
(keycast-tab-bar-mode 1)

(require 'highlight-leading-spaces)
(highlight-leading-spaces-mode 1)

(require 'simple-modeline)
(simple-modeline-mode 1)

(require 'agitate)

(require 'tabnine)
(tabnine-mode 1)

(require 'org)
(setq org-hide-leading-stars t)

(let* ((variable-tuple
        (cond ((x-family-fonts "Roboto Mono")    '(:family "Roboto Mono"))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces
   'user
   `(org-level-8 ((t (,@headline ,@variable-tuple))))
   `(org-level-7 ((t (,@headline ,@variable-tuple))))
   `(org-level-6 ((t (,@headline ,@variable-tuple))))
   `(org-level-5 ((t (,@headline ,@variable-tuple))))
   `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
   `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
   `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
   `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
   `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; (require 'ysz-addons)
