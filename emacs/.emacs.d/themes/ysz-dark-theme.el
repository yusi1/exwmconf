(deftheme ysz-dark
  "My theme"
  :background-mode 'dark)

(custom-theme-set-faces
 'ysz-dark
 '(default ((t :foreground "white" :background "#333")))
 '(line-number ((t :background "#222" :inherit (shadow))))
 '(line-number-current-line ((t :background "#222" :bold t :foreground "aqua")))
 '(mode-line ((t :foreground "white" :background "#555" :box (:line-width (1 . -1) :style released-button))))
 '(mode-line-inactive ((t :inherit shadow :background "#222" :slant italic)))
 '(region ((t :background "#555")))
 '(highlight ((t :inherit region)))
 '(vertico-current ((t :background "dim gray" :foreground "white")))
 '(vertico-mouse ((t :inherit vertico-current)))
 '(orderless-match-face-0 ((t :background "medium spring green" :foreground "black")))
 '(orderless-match-face-1 ((t :background "blue violet" :foreground "white")))
 '(orderless-match-face-2 ((t :background "orange" :foreground "black")))
 '(orderless-match-face-3 ((t :background "dodger blue" :foreground "white")))
 ;; '(success ((t :bold t :background "green1" :foreground "black"))) ; FIXME: setting this breaks orderless-match-faces-* faces in `consult-file'.
 ;; '(isearch ((t :background "green" :foreground "black")))
 '(isearch ((t :background "lime green" :foreground "black")))
 '(lazy-highlight ((t :inherit region)))
 '(gnus-summary-normal-unread ((t :extend t :bold t :foreground "aqua")))
 '(gnus-summary-normal-read ((t :extend t :foreground "palegreen" :bold t)))
 '(hl-line ((t :extend t :background "gray26")))
 '(font-lock-comment-face ((t :foreground "chocolate1" :slant italic)))
 '(font-lock-function-name-face ((t :foreground "lightskyblue" :bold t)))
 '(vc-edited-state ((t :foreground "orange")))
 '(vc-up-to-date-state ((t :foreground "green")))
 '(erc-input-face ((t :foreground "aqua")))
 '(erc-nick-default-face ((t :inherit erc-input-face))))

(provide-theme 'ysz-dark)
