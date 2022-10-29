;;; EXWM window-management configurations --- ysz-desktop-window.el

;; (use-package exwm-firefox
;;   :straight '(exwm-firefox :type git :host nil
;; 			   :repo "https://codeberg.org/emacs-weirdware/exwm-firefox")
;;   :config
;;   (exwm-firefox-mode))

(defun ysz-exwm/exwm-window-config ()
    "Window management related configs for EXWM."
    (defun ysz-exwm/fmat-wintitle-firefox (title &optional length)
      "Removes noise from and trims Firefox window titles."
      (let* ((length (or length 55))
             (title (concat "F# " (replace-regexp-in-string " [-—] Mozilla Firefox$" "" title))))
	(reverse (string-truncate-left (reverse title) length))))

    (defun ysz-exwm/buffer-name ()
      "Guesses (and formats) the buffer name using the class of the X client."
      (let ((title exwm-title)
	    (formatter (intern
			(format "ysz-exwm/fmat-wintitle-%s"
				(downcase exwm-class-name)))))
	(if (fboundp formatter)
            (funcall formatter title)
	  title)))
    
    (add-hook 'exwm-update-title-hook
	      (lambda ()
		(progn
		  (exwm-workspace-rename-buffer
		   (ysz-exwm/buffer-name)))))
    (add-list-to-list 'display-buffer-alist
		      '(("pavucontrol"
			 (display-buffer-in-side-window)
			 (side . bottom)
			 (window-height . 10)))))

(provide 'ysz-desktop-window)
;;; ysz-desktop-window.el ends here
