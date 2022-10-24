(require 'powerline)
(require 'airline-themes)

(load-theme 'airline-doom-one t)

(progn
  ;; Hide Evil and buffer state on inactive buffers.
  ;; Valid Values: t (hidden), nil (shown)
  (setq airline-hide-state-on-inactive-buffers t)

  ;; Hide eyebrowse indicator on inactive buffers.
  ;; Valid Values: t (hidden), nil (shown)"
  (setq airline-hide-eyebrowse-on-inactive-buffers t)

  ;; Hide vc branch on inactive buffers:
  ;; Valid Values: t (hidden), nil (shown)
  (setq airline-hide-vc-branch-on-inactive-buffers nil)

  ;; Set eshell prompt colors to match the airline theme.
  ;; Valid Values: t (enabled), nil (disabled)
  (setq airline-eshell-colors t)

  ;; Set helm colors to match the airline theme.
  ;; Valid Values: t (enabled), nil (disabled)
  (setq airline-helm-colors t)

  ;; Set the cursor color based on the current evil state.
  ;; Valid Values: t (enabled), nil (disabled)
  (setq airline-cursor-colors t)

  ;; Display the currend directory along with the filename.
  ;; Valid Values: 'airline-directory-full
  ;;               'airline-directory-shortened
  ;;               nil (disabled)
  (setq airline-display-directory nil)

  ;; Max directory length to display when using 'airline-directory-shortened
  (setq airline-shortened-directory-length 30)

  ;; Unicode character choices
  (setq airline-utf-glyph-separator-left #x007c
	airline-utf-glyph-separator-right #xe0b2
	airline-utf-glyph-subseparator-left #x007c
	airline-utf-glyph-subseparator-right #x007c
	airline-utf-glyph-branch #xe0a0
	airline-utf-glyph-readonly #xe0a2
	airline-utf-glyph-linenumber #x2630)

  ;; You may also wish to force powerline to use utf8 character separators
  (setq powerline-default-separator 'utf-8)
  (setq powerline-utf-8-separator-left  #x007c
	powerline-utf-8-separator-right #x007c))

(provide 'powerline-setup)
