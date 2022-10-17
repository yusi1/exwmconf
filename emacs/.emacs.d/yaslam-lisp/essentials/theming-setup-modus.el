(require 'modus-themes)

;; Put theme customization here

(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-region '(bg-only no-extend)
      modus-themes-subtle-line-numbers t
      modus-themes-variable-pitch-ui t
      modus-themes-deuteranopia nil
      modus-themes-bold-constructs t
      modus-themes-diffs 'nil
      modus-themes-mixed-fonts t
      ;; modus-themes-mixed-fonts nil
      )

;; More customizations
;; https://github.com/protesilaos/modus-themes/
(setq
 ;; Options for `modus-themes-mode-line' are either nil, or a list
 ;; that can combine any of `3d' OR `moody', `borderless',
 ;; `accented', a natural number for extra padding (or a cons cell
 ;; of padding and NATNUM), and a floating point for the height of
 ;; the text relative to the base font size (or a cons cell of
 ;; height and FLOAT)
 ;; modus-themes-mode-line '(accented borderless (padding . 4) (height . 1.0))
 ;; modus-themes-mode-line '(accented (padding . 0))
 ;; modus-themes-mode-line '(borderless (padding . 4) (height . 1.0))
 modus-themes-mode-line '(borderless)

 ;; Options for `modus-themes-hl-line' are either nil (the default),
 ;; or a list of properties that may include any of these symbols:
 ;; `accented', `underline', `intense'
 modus-themes-hl-line '(underline accented)

 ;; The `modus-themes-completions' is an alist that reads three
 ;; keys: `matches', `selection', `popup'.  Each accepts a nil
 ;; value (or empty list) or a list of properties that can include
 ;; any of the following (for WEIGHT read further below):
 ;;
 ;; `matches' - `background', `intense', `underline', `italic', WEIGHT
 ;; `selection' - `accented', `intense', `underline', `italic', `text-also' WEIGHT
 ;; `popup' - same as `selected'
 ;; `t' - applies to any key not explicitly referenced (check docs)
 ;;
 ;; WEIGHT is a symbol such as `semibold', `light', or anything
 ;; covered in `modus-themes-weights'.  Bold is used in the absence
 ;; of an explicit WEIGHT.
 modus-themes-completions '((matches . (extrabold))
                            (selection . (semibold accented))
                            (popup . (accented intense)))

 ;; Options for `modus-themes-region' are either nil (the default),
 ;; or a list of properties that may include any of these symbols:
 ;; `no-extend', `bg-only', `accented'
 modus-themes-region '(bg-only no-extend)

 modus-themes-markup '(bold background)

 ;; Options for `modus-themes-syntax' are either nil (the default),
 ;; or a list of properties that may include any of these symbols:
 ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
 modus-themes-syntax '(yellow-comments green-strings)

 ;; Options for `modus-themes-links' are either nil (the default),
 ;; or list of properties that may include any of these symbols:
 ;; `faint', `underline', `neutral-underline',`no-underline', `no-color', `bold', `italic', `background'
 modus-themes-links '(faint neutral-underline)

 modus-themes-org-blocks 'tinted-background ; {nil,'gray-background,'tinted-background}

 modus-themes-org-agenda ; this is an alist: read the manual or its doc string
 '((header-block . (variable-pitch 1.3))
   (header-date . (grayscale workaholic bold-today 1.1))
   (event . (accented varied))
   (scheduled . uniform)
   (habit . traffic-light))

 ;; Options for `modus-themes-lang-checkers' are either nil (the
 ;; default), or a list of properties that may include any of these
 ;; symbols: `straight-underline', `text-also', `background',
 ;; `intense' OR `faint'.
 modus-themes-lang-checkers (quote (straight-underline intense))

 )

(if (string-match-p (system-name) "voiddesktop")
    (setq  modus-themes-headings ; this is an alist: read the manual or its doc string
	   '((1 . (light variable-pitch 1.2))
	     (2 . (monochrome 1.0))
	     (t . (semibold)))
	   )
  (setq modus-themes-headings ; this is an alist: read the manual or its doc string
	'((1 . (light variable-pitch 1.5))
	  (2 . (monochrome 1.05))
	  (t . (semibold)))
	))

;; Load the theme files before enabling a theme (else you get an error).
(modus-themes-load-themes)

;; Override the `modus-operandi' theme colours when using the laptop.
;; Since the laptop display sucks at displaying white and less strong colours.
;; (if (string-match-p (system-name) "MX-Laptop")
;;     (setq modus-themes-operandi-color-overrides
;; 	  '((bg-main . "#ededed")
;; 	    (bg-dim . "#faf6ef")
;; 	    (bg-alt . "#f7efe5")
;; 	    (bg-active . "#dbdbdb")
;; 	    (bg-inactive . "#f6ece5")
;; 	    (bg-completion . "#9cdbff")
;; 	    (bg-completion-subtle . "#9cdbff")
;; 	    (cyan-subtle-bg . "#a2e8ff")
;; 	    (fg-diff-removed . "#4b1010")
;; 	    (bg-diff-removed . "#ffc3d5")
;; 	    )))

;; Predicate function to get dark mode preference from GNOME.
(defun get-dark-preference-p ()
  "Get the GNOME dark preference using `gsettings'.
Return `t' if GNOME is in dark mode, else, return `nil'."
  (if (string-match-p "dark"
		      (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme"))
      t
    nil))

;; A simple check to load the desired theme at startup based on what
;; the global preference for GNOME is.  If such preference is not
;; registered, it just loads `modus-operandi'.
;; (if (get-dark-preference-p)
;;     (modus-themes-load-vivendi)
;;   (modus-themes-load-operandi))

;; Check to load a theme based on time of day.
(defun ysz/modus-load-theme-tod ()
  "Load a modus theme based on the time of day returned by `date'."
  (interactive)
  (let ((time (string-to-number (shell-command-to-string "date +'%H%M' | perl -pe 'chomp'")))
	(day (string-to-number "0700"))
	(night (string-to-number "1900")))
    (if (and (> time day)
	     (< time night))
	(if (not (get-dark-preference-p))
	    (modus-themes-load-operandi)
	  (modus-themes-load-vivendi))
      (modus-themes-load-vivendi))))

(modus-themes-load-vivendi)

;; Set a keybind to toggle between light/dark mode on modus-* themes..
(gkey "<f12>" 'modus-themes-toggle)

(provide 'theming-setup-modus)
