(require 'exwm)

(add-hook 'exwm-init-hook (lambda ()
			    (progn
			      (require 'exwm-outer-gaps)
			      (exwm-outer-gaps-mode 1))))

(unless (get 'exwm-input-global-key 'saved-value)
  (add-to-list 'exwm-input-global-keys
	       `([?\s-G] . exwm-outer-gaps-mode)))

(provide 'exwm-outer-gaps-setup)
