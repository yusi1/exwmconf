fundamental-mode ;; Available everywhere

(today (format-time-string "%Y-%m-%d"))
(date "[" (shell-command-to-string "date +'%Y-%m-%d %a %R' | tr -d '\n'") "]" q)
(dateplain (shell-command-to-string "date +'%Y-%m-%d %T %z' | tr -d '\n'") q)
(dateplain2 (shell-command-to-string "date +'%Y-%m-%d %T' | tr -d '\n'") q)
(name (insert "Yusef Aslam"))

text-mode

(cut "--8<---------------cut here---------------start------------->8---" n r n
     "--8<---------------cut here---------------end--------------->8---" n)
(asciibox "+-" (make-string (length str) ?-) "-+" n
          "| " (s str)                       " |" n
          "+-" (make-string (length str) ?-) "-+" n)
(rot13 (p "plain text" text) n "----" n (rot13 text))
(base64 (p "plain text" text) n "----" n (base64-encode-string text))
(calc (p "taylor(sin(x),x=0,3)" formula) n "----" n (format "%s" (calc-eval formula)))
(septitle "..........." n r> (p "INSERT TITLE HERE" title) n>)
(title n (make-string (length title) ?=) n (p "Title: " title) n (make-string (length title) ?=) n)
(insanetitle "--" (make-string (length title) ?-) "--" n>
       "()" (make-string (length title) ?\() "()" n>
       "| " (r "Title:" title) " |" n>
       "()" (make-string (length title) ?\)) "()" n>
       "--" (make-string (length title) ?-) "--" n>
       )

org-mode

(s "#+BEGIN_SRC " p n n> r> n n "#+END_SRC")
(elisp "#+BEGIN_SRC emacs-lisp" n n> r> n n "#+END_SRC"
       :post (org-edit-src-code))
(bash "#+BEGIN_SRC bash" n n> r> n n "#+END_SRC"
      :post (org-edit-src-code))
(python "#+BEGIN_SRC python" n n> r> n n "#+END_SRC"
	:post (org-edit-src-code))
(shell "#+BEGIN_SRC shell" n n> r> n n "#+END_SRC"
       :post (org-edit-src-code))

(title "#+TITLE: " p n "#+AUTHOR: Yusef Aslam" n n %)
(quote "#+BEGIN_QUOTE" n n> r> n> n "#+END_QUOTE")

emacs-lisp-mode

(dl "(dolist (" p ")" n> r> ")")
(dvl "(dolist (" (p "VARIABLE NAME") " '(" (p "ELEMENT" emnt) "\n" > (p "ELEMENT" emnt1) "))")
(fun "(defun " p " (" p ")\n  \"" p "\"" n> r> ")")
(infun "(defun " p " (" p ")" n> "\"" p "\"" n> "(interactive)" n> p ")")
(up "(use-package " p n>
     ":demand nil" p n> n>
     ":commands (some-function-that-the-package-uses some-other-function-that-it-uses)" p n> n>
     ":custom" n> "(some-function-to-be-set-before-package-loads t)" p n> n>
     ":init" n> "(setq some-var-to-be-set-before-package-loads t)" p n> n>
     ":hook (some-hook . some-function)" p n> n>
     ":bind ((:map some-map" n> "(\"KEY\" . some-function)" "))" p n> n>
     ":config" n> "(setq some-var nil))" p)
(upgh "(use-package " p n>
       ":straight (" (p "name of package" name) " " ":type git :host github" n>
       ":repo \"repo-name" p "/" name "\")" n> n>
       ":hook " "(some-hook . some-mode)" p ")")
(upm "(use-package " p n>
     ":init" n>
     "(" p "))")
(link ";; " :post (yank))

lisp-mode emacs-lisp-mode

(title ";;; ==" (make-string (length title) ?=) "==" n>
       ";;; | " (p "Title:" title) " |" n>
       ";;; ==" (make-string (length title) ?=) "==" n>
       )

(insanetitle ";;; --" (make-string (length title) ?-) "--" n>
       ";;; ()" (make-string (length title) ?\() "()" n>
       ";;; | " (r "Title:" title) " |" n>
       ";;; ()" (make-string (length title) ?\)) "()" n>
       ";;; --" (make-string (length title) ?-) "--" n>
       )

(asciibox ";;; +----" (make-string (length str) ?-) "----+" n
          ";;; |    " (s str)                       "    |" n
          ";;; +----" (make-string (length str) ?-) "----+" n)

web-mode html-mode mhtml-mode

(tr "<tr>" n> p q n> "</tr>")
(td "<td>"pq"</td>")
(c "<code>"pq"</code>")
(update "<cite>" "Last updated: " (shell-command-to-string "date +'%Y-%m-%d %T' | tr -d '\n'") "</cite>" q)

;; Local Variables:
;; mode: lisp-data
;; outline-regexp: "[a-z]"
;; End:
