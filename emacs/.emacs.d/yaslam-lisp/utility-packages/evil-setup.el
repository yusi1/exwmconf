(require 'evil)
(require 'evil-smartparens)
(require 'evil-mc)

(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bb") 'consult-buffer)
(evil-define-key 'normal 'global (kbd "<leader>bk") 'kill-buffer)
(evil-define-key 'normal 'global (kbd "<leader>o") 'other-window)
(evil-define-key 'normal 'global (kbd "<leader>0") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>1") 'delete-other-windows)
(evil-define-key 'normal 'global (kbd "<leader>2") 'split-window-below)
(evil-define-key 'normal 'global (kbd "<leader>3") 'split-window-right)

(add-hook 'prog-mode-hook 'evil-smartparens-mode)
(evil-mode 1)

(provide 'evil-setup)
