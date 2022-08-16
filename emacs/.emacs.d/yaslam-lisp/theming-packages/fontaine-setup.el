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
			 (regular-desktop
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 150
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
			 (large-desktop
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 170
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
			 (cascadia-code-regular
			  :default-family "Cascadia Code"
			  :default-weight normal
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  ;; :variable-pitch-family "Source Sans Pro"
			  :variable-pitch-family "Cascadia Code"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family "Cascadia Code Bold"
			  :bold-weight bold
			  :italic-family "Cascadia Code"
			  :italic-slant italic
			  :line-spacing 1)
			 ))


(defun get-de-return-p ()
  (if (not (string-match-p (get-de-p) ""))
      t))

(if (display-graphic-p)
    (if (string-match-p (system-name) "fedora")
        (if (get-de-return-p)
	    (fontaine-set-preset 'large)
	  (fontaine-set-preset 'regular))
      (if (get-de-return-p)
	  (fontaine-set-preset 'regular-desktop)
	(fontaine-set-preset 'large-desktop))))

(provide 'fontaine-setup)
