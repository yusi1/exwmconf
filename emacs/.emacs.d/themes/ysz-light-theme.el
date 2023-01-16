(deftheme ysz-light
  "My theme")

(custom-theme-set-faces
 'ysz-light
 '(default ((t :foreground "black" :background "gray80")))
 '(line-number ((t :background "gray75" :inherit (shadow))))
 '(line-number-current-line ((t :background "#222" :bold t :foreground "aqua")))
 '(mode-line ((t :foreground "white" :background "#555" :box (:line-width (1 . -1) :style released-button))))
 '(mode-line-inactive ((t :inherit shadow :background "#222" :slant italic)))
 '(region ((t :background "#555")))
 '(highlight ((t :inherit region)))
 '(vertico-current ((t :background "dim gray" :foreground "black")))
 '(vertico-mouse ((t :inherit vertico-current)))
 '(orderless-match-face-0 ((t :background "medium spring green" :foreground "black")))
 '(orderless-match-face-1 ((t :background "blue violet" :foreground "black")))
 '(orderless-match-face-2 ((t :background "orange" :foreground "black")))
 '(orderless-match-face-3 ((t :background "dodger blue" :foreground "black")))
 ;; '(success ((t :bold t :background "green1" :foreground "black"))) ; FIXME: setting this breaks orderless-match-faces-* faces in `consult-file'.
 '(isearch ((t :background "green" :foreground "black")))
 '(lazy-highlight ((t :inherit region)))
 '(gnus-summary-normal-unread ((t :extend t :bold t :foreground "aqua")))
 '(hl-line ((t :extend t :background "gray26"))))

(provide-theme 'ysz-light)
