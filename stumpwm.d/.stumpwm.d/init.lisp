;; -*-lisp-*-

(in-package :stumpwm)

;; Needed for StumpWM modules support and other
;; things
(load "~/quicklisp/setup.lisp")

(load "~/.stumpwm.d/autostart.lisp")

;; Start mode line
;;(mode-line)

;; startup slynk server for StumpWM REPL in Emacs
(ql:quickload :slynk)
;; (slynk:create-server :dont-close t)

;; change the prefix key to something else
(set-prefix-key (kbd "C-t"))

;; fix space around Emacs frame
;; https://github.com/stumpwm/stumpwm/issues/719
(setf *ignore-wm-inc-hints* t)

;; window border style
(setf *window-border-style* :thick)

;; window border width
;; The width in pixels given to the borders of regular windows.
(setf *normal-border-width* 2)
;; The width in pixels given to the borders of windows with maxsize or ratio hints.
(setf *maxsize-border-width* 2)
;; The width in pixels given to the borders of transient or pop-up windows.
(setf *transient-border-width* 4)

;; window border colors
(set-focus-color "gray")
(set-unfocus-color "black")

;; mode line colors
(setf *mode-line-background-color* "black")
(setf *mode-line-foreground-color* "green")
(setf *mode-line-border-color* "black")

;; function from the manual to add right-click delete window to the mode-line.
(labels ((ml-on-click-focus-or-delete-window (code id &rest rest)
                (declare (ignore rest))
                (when-let ((window (window-by-id id)))
                  (let ((button (decode-button-code code)))
                    (case button
                      ((:left-button)
                       (focus-all window))
                      ((:right-button)
                       (delete-window window)))))))
       (register-ml-on-click-id :ml-on-click-focus-window
                                #'ml-on-click-focus-or-delete-window))

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;; Read some doc
(define-key *root-map* (kbd "d") "exec gv")
;; Browse somewhere
(define-key *root-map* (kbd "b") "colon1 exec firefox-bin http://www.")
;; Ssh somewhere
(define-key *root-map* (kbd "C-s") "colon1 exec gnome-terminal -- tmux new-session ssh ")
;; Lock screen
(define-key *root-map* (kbd "C-l") "exec slock")
;; Turn off screen
(define-key *top-map* (kbd "Pause") "exec xset dpms force off")

;; log out keybind
(define-key *top-map* (kbd "C-M-DEL") "quit-confirm")

;; toggle modeline
(define-key *root-map* (kbd "M") "mode-line")

;; laptop brightness control keybinds
(define-key *top-map* (kbd "XF86MonBrightnessUp") "exec sleep 0.1 && ~/stuff/brightness-control.sh -i 2000")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "exec sleep 0.1 && ~/stuff/brightness-control.sh -d 2000")

;; set display configuration using a keybind
(define-key *root-map* (kbd "F12") "exec autorandr -c")

;; Send raw key, for example when you need to press C-t to open a new
;; tab in a browser, StumpWM intercepts this, thus you can't open a new tab.
;; So `send-raw-key' does exactly what is said on the tin, it sends the raw C-t so that
;; you can open a new tab.
(define-key *root-map* (kbd "C-q") "send-raw-key")

;; Open gnome-terminal
(define-key *root-map* (kbd "c") "exec uxterm")
(define-key *root-map* (kbd "C-c") "exec uxterm")

;; Kill windows
;; (define-key *group-root-map* (kbd "C-x") "delete")

;; ;; Restart stumpWM
;; (defcommand restart-hard-slynk () ()
  ;; (restart-hard)
  ;; (slynk:restart-server :port 4005))

;; (define-key *root-map* (kbd "C-r") "restart-hard")

;; My own mini run keymap for opening either dmenu or rofi.
;; (defvar *my-run-bindings*
;;   (let ((m (make-sparse-keymap)))
;;     (define-key m (kbd "r") "exec rofi -show combi")
;;     (define-key m (kbd "t") "exec ~/stuff/rofi-tmux-sessions.sh")
;;     (define-key m (kbd "d") "exec dmenu_run")
;;     m
;;     ))

;; (define-key *top-map* (kbd "C-r") `*my-run-bindings*)

;; Application launchers
(define-key *top-map* (kbd "s-r") "exec rofi -show drun")
(define-key *top-map* (kbd "s-p") "exec dmenu_run -fn \"Iosevka Comfy Wide Fixed:size=14\" -nb \"#000000\" -sb \"darkblue\" -nf \"white\"")
(define-key *top-map* (kbd "s-=") "exec ~/stuff/rofi-tmux-sessions.sh")

;; Fullscreen
(define-key *top-map* (kbd "s-f") "fullscreen")

;; Volume control
(define-key *top-map* (kbd "s-F8") "exec pamixer -i 2")
(define-key *top-map* (kbd "s-F7") "exec pamixer -d 2")
(define-key *top-map* (kbd "s-F5") "exec pamixer -t")

;; My own mini interactive navigation keymap for navigating windows
;; in the current group.
(defun before-navi () (message "NAVI Started."))
(defun after-navi () (message "NAVI Stopped."))

(define-interactive-keymap navi (:on-enter #'before-navi
				 :on-exit #'after-navi
				 :exit-on ((kbd "RET")
					   (kbd "ESC")
					   (kbd "C-g")
					   ;(kbd "k")
					   ))
 ((kbd "]") "pull-hidden-next")
 ((kbd "[") "pull-hidden-previous")
 ((kbd "TAB") "expose" t)
 ((kbd "k") "delete" nil))

(define-key *tile-group-root-map* (kbd "C-[") "navi")
(define-key *tile-group-root-map* (kbd "[") "navi")

;; My own mini interactive navigation keymap for navigating groups.
(defun before-gnavi () (message "Group NAVI Started."))
(defun after-gnavi () (message "Group NAVI Stopped."))

;; Kill all windows in the current group and also remove it.
(defcommand kill-group-and-windows () ()
  (kill-windows-current-group)
  (gkill))

(define-interactive-keymap gnavi (:on-enter #'before-gnavi
				  :on-exit #'after-gnavi
				  :exit-on ((kbd "RET")
					    (kbd "ESC")
					    (kbd "C-g")))
  ((kbd "]") "gnext")
  ((kbd "[") "gprev")
  ((kbd "TAB") "grouplist" t)
  ((kbd "w") "kill-windows-current-group" nil)
  ((kbd "C-w") "kill-group-and-windows" t)
  ((kbd "r") "gkill" t))

(define-key *groups-map* (kbd "[") "gnavi")

;; Key remapping
(define-remapped-keys
    `((,(lambda (win)
	  (or
	   (string-equal "Chrome" (window-class win))
	   (string-equal "Brave-browser" (window-class win))
	   (string-equal "Firefox" (window-class win))
	   (string-equal "Chromium" (window-class win))))
	("C-n" . "Down")
	("C-p" . "Up")
	;; ("C-f" . "C-TAB")
	;; ("C-b" . "C-S-TAB")
	("C-k" . "C-w")
	("M-w" . "C-c")
	("C-y" . "C-v")
	("M-less" . "Home")
	("M-greater" . "End"))))

;; Web jump (works for DuckDuckGo and Imdb and any other search engine that supports
;;           the query in the url)
(defmacro make-web-jump (name prefix)
  `(defcommand ,(intern name) (search) ((:rest ,(concatenate 'string name " search: ")))
    (nsubstitute #\+ #\Space search)
    (run-shell-command (concatenate 'string ,prefix search))))

(make-web-jump "duckduckgo" "qutebrowser https://duckduckgo.com/?q=")
(make-web-jump "imdb" "qutebrowser http://www.imdb.com/find?q=")

(define-key *root-map* (kbd "M-s") "duckduckgo")
(define-key *root-map* (kbd "M-i") "imdb")

;; Message window font
(set-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-15")

;;; Define window placement policy...

;; Clear rules
(clear-window-placement-rules)

;; Last rule to match takes precedence!
;; TIP: if the argument to :title or :role begins with an ellipsis, a substring
;; match is performed.
;; TIP: if the :create flag is set then a missing group will be created and
;; restored from *data-dir*/create file.
;; TIP: if the :restore flag is set then group dump is restored even for an
;; existing group using *data-dir*/restore file.
(define-frame-preference "Default"
  ;; frame raise lock (lock AND raise == jumpto)
  (0 t nil :class "Konqueror" :role "...konqueror-mainwindow")
  (1 t nil :class "XTerm"))

(define-frame-preference "Ardour"
  (0 t   t   :instance "ardour_editor" :type :normal)
  (0 t   t   :title "Ardour - Session Control")
  (0 nil nil :class "XTerm")
  (1 t   nil :type :normal)
  (1 t   t   :instance "ardour_mixer")
  (2 t   t   :instance "jvmetro")
  (1 t   t   :instance "qjackctl")
  (3 t   t   :instance "qjackctl" :role "qjackctlMainForm"))

;;; Mode line format
;; Battery information module
(load-module "battery-portable")
;; WIFI information module
(load-module "wifi")
;; Network information module
;; (load-module "net")
;; Disk information module
(load-module "disk")
;; Disk module configuration
(setf disk:*disk-usage-paths* '("/" "/home"))
;; Ram information module
(load-module "mem")
;; maildir module
;; (load-module "maildir")
;; (setf maildir:*maildir-alist* '((Personal . "/home/yaslam/mail")))
;; Time modeline format
(setf stumpwm:*time-modeline-string* "%a %b %e %H:%M")
;; Window modeline format
(setf stumpwm:*window-format* "%m%n%s%10t")
;; Format
(setf stumpwm:*screen-mode-line-format*
      (list
       "[^B%n^b] %W"
       ;; '(:eval (enabled-minor-modes))
       "^>(^B^*%d^*^b)"
       ;; "%T"
       '(:eval
	 (stumpwm:run-shell-command "printf \"\\n\"" t))
       "(^BBAT: %B^b)"
       " [^BWIFI: %I^b]"
       " [^B%D^b]"
       " [^B%M^b]"
       "^>[^B"
       '(:eval (stumpwm:run-shell-command
		"uname -rs | perl -pe 'chomp'" t))
       "^*^b]"))

;; Testing some functions
(defcommand now-we-are-six (name age)
  ((:string "Enter your name: ")
   (:number "Enter your age: "))
  (message "~a, in six years you will be ~a" name (+ 6 age)))

(defcommand return-date () ()
  (run-shell-command "date" t))

;; Module config
(load-module "productivity")

(define-key *top-map* (kbd "s-#") "productivity-mode-toggle")

(setf productivity::*productivity-keys*
      '(("C-t" *root-map*)))

(load-module "app-menu")

(defcommand chromium () ()
  "run chromium"
  (run-or-raise "chromium" '(:class "Chromium")))

(defcommand emacs () ()
  "run emacs"
  (run-or-raise "emacs" '(:class "Emacs")))

(defcommand steam () ()
  "run steam"
  (run-or-raise "steam" '(:class "Steam")))

(setq app-menu:*app-menu*
      '(("INTERNET"
	 ;; submenu
	 ;; call stumpwm command
	 ("Chromium" chromium))
	("PROGRAMMING"
	 ("Emacs" emacs))
	("GAMING"
	 ("Steam" "stumpish gnew Gaming && sleep 2"
	  steam)
	 ("SuperTuxKart" "supertuxkart"))))

(define-key *top-map* (kbd "M-`") "show-menu")

;; Backlight module
;; (load-module "stump-backlight")

;; NetworkManager module
(load-module "stump-nm")

(defun before-nm () (message "Started NetworkManager keymap.."))
(defun after-nm () (message "Stopped NetworkManager keymap.."))

(define-interactive-keymap networkmanager (:on-enter #'before-nm
					   :on-exit #'after-nm
					   :exit-on ((kbd "RET")
						     (kbd "ESC")
						     (kbd "C-g")))
  ((kbd "w") "nm-list-wireless-networks" t)
  ((kbd "v") "nm-list-vpn-connections" t))

(define-key *root-map* (kbd "N") "networkmanager")

;; Screenshot module
(load-module "screenshot")

(defun before-screenshot () (message "Started Screenshot keymap.."))
(defun after-screenshot () (message "Stopped Screenshot keymap.."))

(define-interactive-keymap screenshot-map (:on-enter #'before-screenshot
					   :on-exit #'after-screenshot
					   :exit-on ((kbd "RET")
						     (kbd "ESC")
						     (kbd "C-g")))
  ((kbd "w") "screenshot-window" t)
  ((kbd "a") "screenshot-area" nil)
  ((kbd "s") "screenshot" t))

(define-key *top-map* (kbd "SunPrint_Screen") "screenshot-map")

;;; Minor mode stuff
;; An example minor mode from the StumpWM manual
(define-minor-mode swm-evil-mode () ()
  (:scope :screen)
  (:interactive t)
  (:top-map '(("i" . "swm-evil-mode")
              ("j" . "move-focus down")
              ("k" . "move-focus up")
              ("h" . "move-focus left")
              ("l" . "move-focus right")
              ("p" . "pull-hidden-previous")
              ("n" . "pull-hidden-next")
              ("S" . "hsplit")
              ("s" . "vsplit")
              ("r" . "remove-split")
              ("g" . *groups-map*)
              ("x" . *exchange-window-map*)))
  (:lighter-make-clickable nil)
  (:lighter "EVIL"))

(define-key *root-map* (kbd "<") "swm-evil-mode")

;; Pass module
(load-module "pass")

(define-key *top-map* (kbd "s-P") "pass-copy-menu")

;; End session module
;; actually load the module
(load-module "end-session")

(define-key *top-map* (kbd "C-M-Delete") "end-session")
