(require 'fontaine)

(setq fontaine-latest-state-file
      (locate-user-emacs-file "fontaine-latest-state.eld"))

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
			 (larger-desktop
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 180
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
			 (curly-large-desktop
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 170
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Iosevka Comfy Motion Duo"
			  :variable-pitch-weight normal
			  :variable-pitch-height 1.0
			  :bold-family nil ; use whatever the underlying face has
			  :bold-weight bold
			  ;; :italic-family "Comic Mono"
			  ;; :italic-slant italic
			  :line-spacing 1
			  )
                         (curly-larger-desktop
			  :default-family "Iosevka Comfy"
			  :default-weight normal
			  :default-height 180
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Iosevka Comfy Motion Duo"
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
			 (ubuntu-regular
			  :default-family "Ubuntu Mono"
			  :default-weight normal
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Ubuntu Mono"
			  :bold-family nil
			  :bold-weight bold
			  :italic-family "Ubuntu Mono"
			  :italic-slant italic
			  :line-spacing 1)
			 (ubuntu-large
			  :default-family "Ubuntu Mono"
			  :default-weight normal
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "Ubuntu Mono"
			  :bold-family nil
			  :bold-weight bold
			  :italic-family "Ubuntu Mono"
			  :italic-slant italic
			  :line-spacing 1)
			 (dejavu-sans-regular
			  :default-family "DejaVu Sans Mono"
			  :default-weight book
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "DejaVu Sans"
			  :bold-family nil
			  :bold-weight bold
			  :italic-family "DejaVu Sans"
			  :italic-slant italic
			  :line-spacing 1)
			 (dejavu-sans-large
			  :default-family "DejaVu Sans Mono"
			  :default-weight book
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "DejaVu Sans"
			  :bold-family nil
			  :bold-weight bold
			  :italic-family "DejaVu Sans Mono"
			  :italic-slant italic
			  :line-spacing 1)
			 (jetbrainsmono-large
			  :default-family "JetBrains Mono"
			  :default-weight regular
			  :default-height 160
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "JetBrainsMono"
			  :bold-family "JetBrainsMono-Bold"
			  :bold-weight bold
			  :italic-family "JetBrainsMono-Italic"
			  :italic-slant italic
			  :line-spacing 1)
			 (jetbrainsmono-larger
			  :default-family "JetBrains Mono"
			  :default-weight regular
			  :default-height 180
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "JetBrainsMono"
			  :bold-family "JetBrainsMono-Bold"
			  :bold-weight bold
			  :italic-family "JetBrainsMono-Italic"
			  :italic-slant italic
			  :line-spacing 1)
			 (jetbrainsmono-regular
			  :default-family "JetBrains Mono"
			  :default-weight regular
			  :default-height 140
			  :fixed-pitch-family nil
			  :fixed-pitch-weight nil
			  :fixed-pitch-height nil
			  :variable-pitch-family "JetBrainsMono"
			  :bold-family "JetBrainsMono-Bold"
			  :bold-weight bold
			  :italic-family "JetBrainsMono-Italic"
			  :italic-slant italic
			  :line-spacing 1)
			 (t
			  :variable-pitch-family "Iosevka Comfy Motion Duo"
			  :variable-pitch-weight nil
			  :variable-pitch-height 1.0)
			 ))

;; Recover last preset or fall back to desired style from
;; `fontaine-presets'.
(if (display-graphic-p)
    (fontaine-set-preset (or (fontaine-restore-latest-preset) 'regular)))

;; The other side of `fontaine-restore-latest-preset'.
(add-hook 'kill-emacs-hook #'fontaine-store-latest-preset)

;; Keybind to change presets
(progn
  (gkey "C-c f" 'fontaine-set-preset)
  (gkey "C-c F" 'fontaine-set-face-font))

(provide 'fontaine-setup)
