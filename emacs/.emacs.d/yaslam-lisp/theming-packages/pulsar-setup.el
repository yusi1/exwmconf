(require 'pulsar)

(let ((map global-map))
  (define-key map (kbd "C-x l") 'pulsar-pulse-line)
  (define-key map (kbd "C-x L") 'pulsar-highlight-line))

(setq pulsar-pulse-functions
      ;; NOTE 2022-04-09: The commented out functions are from before
      ;; the introduction of `pulsar-pulse-on-window-change'.  Try that
      ;; instead.
      '(recenter-top-bottom
        move-to-window-line-top-bottom
        reposition-window
        ;; bookmark-jump
        ;; other-window
        ;; delete-window
        delete-other-windows ; this was originally commented out
        forward-page
        backward-page
        scroll-up-command
        scroll-down-command
	evil-scroll-page-up
	evil-scroll-page-down
        ;; windmove-right
        ;; windmove-left
        ;; windmove-up
        ;; windmove-down
        ;; windmove-swap-states-right
        ;; windmove-swap-states-left
        ;; windmove-swap-states-up
        ;; windmove-swap-states-down
        ;; tab-new
        ;; tab-close
        ;; tab-next
        org-next-visible-heading
        org-previous-visible-heading
        org-forward-heading-same-level
        org-backward-heading-same-level
        outline-backward-same-level
        outline-forward-same-level
        outline-next-visible-heading
        outline-previous-visible-heading
        outline-up-heading
	org-decrypt-entry))

(setq pulsar-pulse-on-window-change t)
(setq pulsar-pulse t)
(setq pulsar-delay 0.055)
(setq pulsar-iterations 10)
(setq pulsar-face 'pulsar-magenta)
(setq pulsar-highlight-face 'pulsar-yellow)

(pulsar-global-mode t)

(provide 'pulsar-setup)
