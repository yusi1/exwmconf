;;; Multimedia configurations for Emacs (EMMS et. al) --- ysz-media.el

(use-package emms
  :straight t
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)

  (require 'emms-player-mpd)
  (setq emms-mpd-server-name "localhost")
  (setq emms-mpd-server-port "6600")
  (add-to-list 'emms-player-list 'emms-player-mpd)
  (emms-cache-set-from-mpd-all)
  (emms-player-mpd-connect)

  (require 'emms-volume)
  (setq emms-volume-change-function 'emms-volume-mpd-change)

  (setq emms-source-file-default-directory "~/Music/"))

(provide 'ysz-media)
;; ysz-media.el ends here
