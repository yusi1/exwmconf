(require 'projectile)
;; projectile ibuffer integration
(require 'ibuffer-projectile)
(add-hook 'ibuffer-hook
	  (lambda ()
	    (ibuffer-projectile-set-filter-groups)
	    (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

(setq ibuffer-formats
      '((mark modified read-only " "
              (name 18 18 :left :elide)
              " "
              (size 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              project-relative-file)))

(projectile-mode +1)
(keymap-set projectile-mode-map "M-P" 'projectile-command-map)

(let ((map projectile-command-map))
  (keymap-set map "B" 'consult-project-buffer))

(gremap projectile-mode-map "consult-project-buffer" 'nil)

(provide 'projectile-setup)
