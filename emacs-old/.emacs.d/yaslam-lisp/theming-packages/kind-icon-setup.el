(require 'kind-icon)

(setq kind-icon-default-face 'corfu-default)

(with-eval-after-load 'corfu
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(provide 'kind-icon-setup)
