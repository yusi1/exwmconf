(let ((dir (expand-file-name user-emacs-directory)))
  (dolist (paths `(,(concat dir "site-lisp")
		   ,(concat dir "load-path")))
    (add-to-list 'load-path paths)))

(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(unless (getenv "XDG_CURRENT_DESKTOP")
  (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
  (add-to-list 'default-frame-alist '(alpha . (90 . 90))))

(load-theme 'modus-vivendi)

(modify-all-frames-parameters '((width . 95)
				(height . 25)))

(progn
  (menu-bar-mode 1)
  (tool-bar-mode -1))

(electric-pair-mode 1)
(global-display-line-numbers-mode 1)

(recentf-mode t)

(setq native-comp-async-report-warnings-errors t)
(setq byte-compile-warnings '(not nresolved
                                  free-vars
                                  callargs
                                  redefine
                                  obsolete
                                  noruntime
                                  cl-functions
                                  interactive-only
                                  ))

(if (fboundp 'pixel-scroll-precision-mode)
    (pixel-scroll-precision-mode t))
