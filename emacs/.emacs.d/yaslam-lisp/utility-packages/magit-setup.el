(require 'magit)

(keymap-set global-map "C-x g" 'magit-status)
(keymap-set ctl-x-map "g" 'magit-status)

(provide 'magit-setup)
