(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "/home/yaslam/.emacs.d/site-lisp")

(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(unless (getenv "XDG_CURRENT_DESKTOP")
  (set-frame-parameter (selected-frame) 'alpha '(90 . 90))
  (add-to-list 'default-frame-alist '(alpha . (90 . 90))))

(load-theme 'modus-vivendi)

(server-start)

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

(modify-all-frames-parameters '((width . 95)
				(height . 25)))

(if (fboundp 'pixel-scroll-precision-mode)
    (pixel-scroll-precision-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit exwm orderless vertico)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'downcase-region 'disabled nil)

(defmacro prot-emacs-builtin-package (package &rest body)
  "Set up builtin PACKAGE with rest BODY.
PACKAGE is a quoted symbol, while BODY consists of balanced
expressions."
  (declare (indent 1))
  `(progn
     (unless (require ,package nil 'noerror)
       (display-warning 'prot-emacs
                        (format "Loading `%s' failed" ,package)
                        :warning))
     ,@body))

(defmacro prot-emacs-elpa-package (package &rest body)
  "Set up PACKAGE from an Elisp archive with rest BODY.
PACKAGE is a quoted symbol, while BODY consists of balanced
expressions.

Try to install the package if it is missing."
  (declare (indent 1))
  `(progn
     (when (not (package-installed-p ,package))
       (unless package-archive-contents
         (package-refresh-contents))
       (package-install ,package))
     (if (require ,package nil 'noerror)
         (progn ,@body)
       (display-warning 'prot-emacs
                        (format "Loading `%s' failed" ,package)
                        :warning))))

(prot-emacs-elpa-package 'orderless
  (setq completion-styles '(orderless basic)
	completion-category-defaults nil
	completion-category-overrides '((file (styles . (partial-completion))))))

(prot-emacs-elpa-package 'vertico
  (vertico-mode 1))

(prot-emacs-elpa-package 'magit
  (keymap-set global-map "C-x g" 'magit))
