;;; Theming configurations --- ysz-theme.el

(use-package modus-themes
  :straight t
  :demand t
  :bind (("<f12>" . modus-themes-toggle))
  :config
  (setq
   ;; modus-themes-mode-line '(3d accented)
   modus-themes-mode-line '(3d)

   modus-themes-headings '((1 . (light variable-pitch 1.5))
			   (2 . (monochrome 1.05))
			   (t . (semibold)))
   modus-themes-org-blocks 'gray-background
   modus-themes-mixed-fonts t)
  ;;;;;;;;;;;;;;
  ;; (if (not (null (getenv "XDG_CURRENT_DESKTOP")))
  ;;     (if (string-match-p "dark"
  ;; 			  (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme"))
  ;; 	  (modus-themes-load-vivendi)
  ;; 	(modus-themes-load-operandi))
  ;;   (modus-themes-load-vivendi))
  ;; (modus-themes-load-vivendi)
  (modus-themes-load-operandi))

;; (use-package green-is-the-new-black-theme
;;   :straight '(green-is-the-new-black-emacs
;; 	      :type git :host github
;; 	      :repo "fredcamps/green-is-the-new-black-emacs")
;;   :config
;;   (load-theme 'green-is-the-new-black t))

;; (use-package retro-green-theme
;;   :config
;;   (load-theme 'retro-green t))

;; (use-package doom-themes
;;   :straight t
;;   :config
;;   ;;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ;; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ;; if nil, italics is universally disabled
;;   (load-theme 'doom-city-lights t)
;;   ;;; Enable flashing mode-line on errors
;;   ;;; (doom-themes-visual-bell-config)
;;   ;;; ;;; Enable custom neotree theme (all-the-icons must be installed!)
;;   ;;; (doom-themes-neotree-config)
;;   ;;; ;;; or for treemacs users
;;   ;;; (setq doom-themes-treemacs-theme "doom-atom") ;; use "doom-colors" for less minimal icon theme
;;   ;;; (doom-themes-treemacs-config)
;;   ;;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package doom-modeline
  :straight t
  :config
  (setq doom-modeline-icon nil)
  (doom-modeline-mode 1))

(use-package fontaine
  :straight t
  :demand t
  :bind (("C-c f" . fontaine-set-preset)
	 ("C-c F" . fontaine-set-face-font)
	 ("C-c r" . (lambda () (interactive)
		      (fontaine-set-preset
		       (fontaine-restore-latest-preset)))))
  :config
  ;; whether fontaine is enabled
  (defvar fontaine-enabled nil "Whether fontaine is enabled or not.")
  (setq fontaine-enabled t)
  
  (setq fontaine-latest-state-file
	(locate-user-emacs-file "fontaine-latest-state.eld"))
  (setq fontaine-presets
	'((iosevka-comfy-regular
	   :default-family "Iosevka Comfy Fixed"
	   :default-height 160
	   :variable-pitch-weight bold
	   :bold-family nil
	   :bold-weight bold
	   :line-spacing 1)
	  (iosevka-comfy-small
	   :default-family "Iosevka Comfy Fixed"
	   :default-height 140
	   :variable-pitch-weight bold
	   :bold-family nil
	   :bold-weight bold
	   :line-spacing 1)
	  (terminus
	   :default-family "Terminus"
	   :default-height 160
	   :default-weight bold)
	  (monoid-regular
	   :default-family "Monoid"
	   :default-height 160
	   :default-weight regular
	   ;; :variable-pitch-family nil
	   :variable-pitch-weight bold
	   :variable-pitch-height 1.2)
	  (monoid-medium
	   :default-family "Monoid"
	   :default-height 140
	   :default-weight regular
	   ;; :variable-pitch-family nil
	   :variable-pitch-weight bold
	   :variable-pitch-height 1.1)
	  (monoid-small
	   :default-family "Monoid"
	   :default-height 120
	   :default-weight regular
	   ;; :variable-pitch-family nil
	   :variable-pitch-weight bold
	   :variable-pitch-height 1.0)
	  (sourcecode-ubuntu-medium
	   :default-family "Source Code Pro"
	   :default-height 140
	   :default-weight regular
	   :variable-pitch-family "Ubuntu Nerd Font"
	   :variable-pitch-height 1.1
	   :variable-pitch-weight bold)
	  (consolas-regular
	   :default-family "Consolas"
	   :default-height 160
	   :default-weight regular)
	  (consolas-medium
	   :default-family "Consolas"
	   :default-height 140
	   :default-weight regular)
	  (fantasque-sans-regular
	   :default-family "Fantasque Sans Mono"
	   :default-height 160
	   :default-weight regular)
	  (fantasque-sans-medium
	   :default-family "Fantasque Sans Mono"
	   :default-height 140
	   :default-weight regular)
	  (t
	   :default-family "FiraCode"
	   :default-weight normal
	   :default-height 140
	   ;; :variable-pitch-family "Iosevka Comfy Motion Duo"
	   :variable-pitch-family "Iosevka Aile"
	   :variable-pitch-weight nil
	   :variable-pitch-height 1.0)))
  (if fontaine-enabled
      (if (display-graphic-p)
	  (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular))))
  (add-hook 'kill-emacs-hook #'fontaine-store-latest-preset))

(use-package cursory
  :straight t
  :bind (("C-c C-p" . cursory-set-preset))
  :config
  (setq cursory-presets
	'((bar
           :cursor-type (bar . 2)
           :cursor-in-non-selected-windows hollow
           :blink-cursor-blinks 10
           :blink-cursor-interval 0.5
           :blink-cursor-delay 0.2)
	  (slow-bar
	   :cursor-type (bar . 2)
	   :cursor-in-non-selected-windows hollow
	   :blink-cursor-blinks 3
	   :blink-cursor-interval 0.8
	   :blink-cursor-delay 0.5)
          (box
           :cursor-type box
           :cursor-in-non-selected-windows hollow
           :blink-cursor-blinks 10
           :blink-cursor-interval 0.5
           :blink-cursor-delay 0.2)
          (underscore
           :cursor-type (hbar . 3)
           :cursor-in-non-selected-windows hollow
           :blink-cursor-blinks 50
           :blink-cursor-interval 0.2
           :blink-cursor-delay 0.2)))
  (setq cursory-latest-state-file (locate-user-emacs-file "cursory-latest-state"))
  (cursory-set-preset (or (cursory-restore-latest-preset) 'box))
  (add-hook 'kill-emacs-hook #'cursory-store-latest-preset))

(use-package diredfl
  :straight t
  :config
  (diredfl-global-mode 1))

(provide 'ysz-theme)
;;; ysz-theme.el ends here
