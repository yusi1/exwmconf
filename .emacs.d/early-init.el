 (setq initial-frame-alist
       '((top . 1) (left . 1) (width . 1920) (height . 1080)))

(setq package-enable-at-startup nil)

(let ((dir (expand-file-name user-emacs-directory)))
  (dolist (paths `(,(concat dir "site-lisp")
		   ,(concat dir "load-path")
		   ,(concat dir "site-lisp/desktop")
		   ,(concat dir "site-lisp/evil")
		   ,(concat dir "site-lisp/xah-fly-keys")))
    (add-to-list 'load-path paths)))

;; Custom theme directory (set to be able to use my own themes)
(setq custom-theme-directory (concat (expand-file-name user-emacs-directory) "themes"))

;; Hide nativecomp warnings
(setq native-comp-async-report-warnings-errors t)
;; Hide bytecomp warning
(setq byte-compile-warnings '(not nresolved
                                  free-vars
                                  callargs
                                  redefine
                                  obsolete
                                  noruntime
                                  cl-functions
                                  interactive-only
                                  ))

;; Keep nativecomp cache clean from older versions
(setq native-compile-prune-cache t)

(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t)))

(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(if (fboundp 'pixel-scroll-precision-mode)
    (pixel-scroll-precision-mode t))

(require 'ysz-compatibility)
(require 'ysz-ui)
