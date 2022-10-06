(require 'flx-isearch)

(flx-isearch-mode)

(gremap global-map "isearch-backward" 'flx-isearch-backward)
(gremap global-map "isearch-forward" 'flx-isearch-forward)

(provide 'flx-isearch-setup)
