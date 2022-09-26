(require 'ef-themes)

;; Disable all other themes to avoid awkward blending:
(mapc #'disable-theme custom-enabled-themes)

;; Check GNOME's gsettings database for the dark theme preference.  If
;; it is enabled, we want to load a dark Ef theme at random.  Otherwise
;; we load a random light theme.
;; (if (string-match-p (shell-command-to-string "echo $XDG_CURRENT_DESKTOP") "GNOME")
;;     (if (string-match-p
;; 	 "dark"
;; 	 (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme"))
;; 	(ef-themes-load-random 'dark)
;;       (ef-themes-load-random 'light))
;;   (ef-themes-load-random 'dark))

;; Heading customization
(setq ef-themes-headings
      (quote ((1 . (regular 1.4))
	      (2 . (monochrome 1.2))
	      (t . (semibold)))))

;; Use mixed-pitch fonts for UI
(setq ef-themes-mixed-fonts t)
;; (setq ef-themes-mixed-fonts nil)

;; Which themes to toggle
;; (setq ef-themes-to-toggle '(ef-deuteranopia-dark ef-deuteranopia-light))
(setq ef-themes-to-toggle '(ef-duo-dark ef-duo-light))
;; (setq ef-themes-to-toggle '(ef-day ef-dark))

(gkey "<f12>" 'ef-themes-toggle)

;; Load the theme of choice:
;; (load-theme 'ef-deuteranopia-dark :no-confirm)
;; (load-theme 'ef-day :no-confirm)
;; (load-theme 'ef-dark :no-confirm)
(load-theme 'ef-duo-dark)

;; The themes we provide:
;;
;; Light: `ef-day', `ef-light', `ef-spring', `ef-summer'.
;; Dark:  `ef-autumn', `ef-dark', `ef-night', `ef-winter'.


;; We also provide these commands, but do not assign them to any key:
;;
;; - `ef-themes-select'
;; - `ef-themes-load-random'
;; - `ef-themes-preview-colors'
;; - `ef-themes-preview-colors-current'

(provide 'theming-setup-ef)
