;;; IRC configurations (ERC et al.) --- ysz-irc.el

(use-package erc
  :config
  ;; Use authinfo instead of prompting for passwords.
  (setq erc-prompt-for-password nil)
  ;; Use NickServ to authenticate.
  (setq erc-use-auth-source-for-nickserv-password t))

(provide 'ysz-irc)
;;; ysz-irc.el ends here
