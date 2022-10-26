;;; Useful configurations --- ysz-utils.el

(use-package pass
  :straight t
  :bind (("C-c p" . pass)))

(use-package org-contacts
  :straight t
  :config
  (setq org-contacts-files '("~/Documents/contacts.org"))

  (with-eval-after-load 'org-capture
    (add-list-to-list 'org-capture-templates
		      '(("c" "Contact Parent")
			("c1" "Contact (Family)" entry (file+headline "~/Documents/contacts.org" "Family")
			 "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:"
			 :empty-lines 1)
			("c2" "Contact (Friend)" entry (file+headline "~/Documents/contacts.org" "Friends")
			 "* %(org-contacts-template-name)
:PROPERTIES:
:NUMBER: %?
:END:"
			 :empty-lines 1)
			("co" "Contact (Other)" entry (file+headline "~/Documents/contacts.org" "Others")
			 "* %(org-contacts-template-name)
:PROPERTIES:
:EMAIL: %(org-contacts-template-email)
:END:"
			 :empty-lines 1)))))

(use-package ibuffer-project
  :straight t)


(provide 'ysz-utils)
;;; ysz-utils.el ends here
