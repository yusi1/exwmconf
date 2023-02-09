;;; IRC configurations (ERC et al.) --- ysz-irc.el

(use-package erc
  :config
  ;; Use authinfo instead of prompting for passwords.
  (setq erc-prompt-for-password nil)
  ;; Use NickServ to authenticate.
  (setq erc-use-auth-source-for-nickserv-password t)

  ;;; FIXME:: [2023-01-22 Sun 01:53]
  ;; Connect to ZNC through ERC and without TLS,
  ;; there is a bug(?) that prevents connecting
  ;; to ZNC through ERC-tls ATM, and we need to
  ;; do it non-interactively because ZNC expects
  ;; the password in the USERNAME field and not
  ;; the NICK field.
  (defun znc-connect-tls ()
   (interactive)
   (erc-tls :server "freebsd-oldman.home" :port 3000 :nick "zncadmin" :user "zncadmin@laptop-emacs/libera" :password "ZNCIRC43521.")))
 

(use-package znc
  :straight t
  :config
  (require 'znc)
  (setq znc-servers '(("freebsd-oldman.home" 3000 t
                       ((libera "zncadmin@laptop-emacs" "ZNCIRC43521."))))))

(use-package circe
  :straight t
  :config
  (setq circe-network-options
        '(("ZNC-Libera"
           :use-tls nil
           :host "freebsd-oldman.home"
           :port "3000"
           :nick "zncadmin@laptop/libera"
           :pass (shell-command-to-string
                  "pass show LAN\\ Passwords/ZNC | head -n1 | tr -d '\n'")))))

(provide 'ysz-irc)
;;; ysz-irc.el ends here
