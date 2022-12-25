(deftheme ysz-dark
  "My theme")

(custom-theme-set-faces
 'ysz-dark
 '(default ((t :foreground "white" :background "#333")))
 '(mode-line ((t :foreground "white" :background "#555" :box (:line-width (1 . -1) :style released-button))))
 '(mode-line-inactive ((t :background "#222" :)))
 '(region ((t :foreground "black" :background "lightgoldenrod2")))
 '(highlight ((t :foreground "black" :background "lightgoldenrod2")))
 '(vertico-current ((t :background "dark cyan" :foreground "white")))
 '(vertico-mouse ((t :inherit vertico-current)))
 '(isearch ((t :background "green" :foreground "white")))
 '(isearch-group-1 ((t :inherit region)))
 '(isearch-group-2 ((t :inherit region))))

(provide-theme 'ysz-dark)
