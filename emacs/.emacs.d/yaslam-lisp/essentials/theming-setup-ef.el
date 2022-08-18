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
;;   (ef-themes-load-random 'light))

;; Load the theme of choice:
(load-theme 'ef-day :no-confirm)

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
