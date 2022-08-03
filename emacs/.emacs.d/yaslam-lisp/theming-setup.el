(require 'modus-themes)

;; Put theme customization here

(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs nil
      modus-themes-region '(bg-only no-extend))

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

 ;; Options for `modus-themes-hl-line' are either nil (the default),
 ;; or a list of properties that may include any of those symbols:
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
 ;; or a list of properties that may include any of those symbols:
 ;; `no-extend', `bg-only', `accented'
 modus-themes-region '(bg-only no-extend)

 modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

 modus-themes-org-agenda ; this is an alist: read the manual or its doc string
 '((header-block . (variable-pitch 1.3))
   (header-date . (grayscale workaholic bold-today 1.1))
   (event . (accented varied))
   (scheduled . uniform)
   (habit . traffic-light))

 ;; Options for `modus-themes-lang-checkers' are either nil (the
 ;; default), or a list of properties that may include any of those
 ;; symbols: `straight-underline', `text-also', `background',
 ;; `intense' OR `faint'.
 modus-themes-lang-checkers (quote (straight-underline intense))

 modus-themes-headings ; this is an alist: read the manual or its doc string
 '((1 . (overline background variable-pitch 1.1))
   (2 . (rainbow 1.08))
   (t . (semibold)))
 )

;; Load the theme files before enabling a theme (else you get an error).
(modus-themes-load-themes)

;; A simple check to load the desired theme at startup based on what
;; the global preference for GNOME is.  If such preference is not
;; registered, it just loads `modus-operandi'.
(if (string-match-p
     "dark"
     (shell-command-to-string
      "gsettings get org.gnome.desktop.interface color-scheme"))
    (modus-themes-load-vivendi)
  (modus-themes-load-operandi))

;; Set a keybind to toggle between light/dark mode on modus-* themes..
(define-key global-map (kbd "<f12>") 'modus-themes-toggle)

(provide 'theming-setup)