(require 'cursory)

(setq cursory-presets
      '((bar
         :cursor-type (bar . 2)
         :cursor-in-non-selected-windows hollow
         :blink-cursor-blinks 10
         :blink-cursor-interval 0.5
         :blink-cursor-delay 0.2)
	(slow-bar
	 :cursor-type (bar . 2)
	 :cursor-in-non-selected-windows hollow
	 :blink-cursor-blinks 3
	 :blink-cursor-interval 0.8
	 :blink-cursor-delay 0.5)
        (box
         :cursor-type box
         :cursor-in-non-selected-windows hollow
         :blink-cursor-blinks 10
         :blink-cursor-interval 0.5
         :blink-cursor-delay 0.2)
        (underscore
         :cursor-type (hbar . 3)
         :cursor-in-non-selected-windows hollow
         :blink-cursor-blinks 50
         :blink-cursor-interval 0.2
         :blink-cursor-delay 0.2)))

(setq cursory-latest-state-file (locate-user-emacs-file "cursory-latest-state"))

;; Set last preset or fall back to desired style from `cursory-presets'.
(cursory-set-preset (or (cursory-restore-latest-preset) 'bar))

;; The other side of `cursory-restore-latest-preset'.
(add-hook 'kill-emacs-hook #'cursory-store-latest-preset)

;; We have to use the "point" mnemonic, because C-c c is often the
;; suggested binding for `org-capture'.
(define-key global-map (kbd "C-c C-p") #'cursory-set-preset)

(provide 'cursory-setup)
