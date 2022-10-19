(require 'exwm)
(require 'exwm-outer-gaps)
(add-hook 'exwm-init-hook (lambda ()
			    (progn
			      (require 'exwm-outer-gaps)
			      (exwm-outer-gaps-mode 1))))

(with-eval-after-load 'exwm
  (unless (get 'exwm-input-global-keys 'saved-value)
    (add-to-list 'exwm-input-global-keys
		 '([?\s-G] . exwm-outer-gaps-mode))))

(provide 'exwm-outer-gaps-setup)
