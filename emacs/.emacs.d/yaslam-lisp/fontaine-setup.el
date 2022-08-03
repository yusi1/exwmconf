(require 'fontaine)

(setq fontaine-presets '((regular
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Iosevka Comfy Duo"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family nil ; use whatever the underlying face has
			  :bold-weight bold
			  ;; :italic-family "Comic Mono"
			  ;; :italic-slant italic
			  :line-spacing 1
			  )
			 (large
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Iosevka Comfy Duo"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family nil ; use whatever the underlying face has
			  :bold-weight bold
			  ;; :italic-family "Comic Mono"
			  ;; :italic-slant italic
			  :line-spacing 1
			  )
			 (comic-regular
			  :default-family "Comic Mono"
			  :default-weight normal
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Comic Sans MS"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Comic Mono Bold"
			  :bold-weight bold
			  :italic-family "Comic Mono"
			  :italic-slant italic
			  :line-spacing 1
			  )
			 (comic-large
			  :default-family "Comic Mono"
			  :default-weight normal
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Comic Sans MS"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Comic Mono Bold"
			  :bold-weight bold
			  :italic-family "Comic Mono"
			  :italic-slant italic
			  :line-spacing 1
			  )
			 (sourcecode-regular
			  :default-family "Source Code Pro"
			  :default-weight normal
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  ;; :variable-pitch-family "Source Sans Pro"
			  :variable-pitch-family "Source Code Variable"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Source Code Pro"
			  :bold-weight bold
			  :italic-family "Source Code Pro"
			  :italic-slant italic
			  :line-spacing 1
			  )
			 (sourcecode-large
			  :default-family "Source Code Pro NF"
			  :default-weight normal
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  ;; :variable-pitch-family "Source Sans Pro"
			  :variable-pitch-family "Source Code Variable"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Source Code Pro"
			  :bold-weight bold
			  :italic-family "Source Code Pro"
			  :italic-slant italic
			  :line-spacing 1
			  )
			 (saucecode-regular
			  :default-family "Sauce Code Pro NF"
			  :default-weight normal
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  ;; :variable-pitch-family "Source Sans Pro"
			  :variable-pitch-family "Source Code Variable"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Sauce Code Pro NF"
			  :bold-weight bold
			  :italic-family "Sauce Code Pro NF"
			  :italic-slant italic
			  :line-spacing 1
			  )
			 (saucecode-large
			  :default-family "Sauce Code Pro NF"
			  :default-weight normal
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  ;; :variable-pitch-family "Source Sans Pro"
			  :variable-pitch-family "Source Code Variable"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Sauce Code Pro NF"
			  :bold-weight bold
			  :italic-family "Sauce Code Pro NF"
			  :italic-slant italic
			  :line-spacing 1
			  )
			 ))

;; First, check if we are in Xorg, if not, don't do anything.
;; If we aren't on a desktop environment which sets the
;; `$XDG_CURRENT_DESKTOP' variable, then use the
;; regular preset.
(if (display-graphic-p)
    (if (string-match (get-de-p) "")
	(fontaine-set-preset 'saucecode-regular)
      (fontaine-set-preset 'saucecode-large)))

(provide 'fontaine-setup)
