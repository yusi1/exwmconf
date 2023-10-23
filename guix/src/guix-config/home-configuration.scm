;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
	     (gnu home services)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages
	    (list
	     "flatpak"
             "dconf-editor"
	     "virt-manager"
	     "vim"
	     "lxappearance"
	     "ublock-origin-icecat"
             "icecat"
             "htop"
             "hexchat"
             "fzf"
             "font-fira-sans"
             "xsettingsd"
             "libvterm"
             "libtool"
             "cmake"
             "emacs-parinfer-mode"
             "emacs-geiser-guile"
             "emacs-geiser"
             "guile"
             "emacs"
             "font-google-noto-emoji"
             "unzip"
             "kakoune"
             "emacs-guix"
             "stow"
             "git"
	     "secrets"
             "keepassxc"
             "ublock-origin-chromium"
             "ungoogled-chromium")))

 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  (list (service home-bash-service-type
                 (home-bash-configuration
                  (aliases '(("grep" . "grep --color=auto")
                             ("ip" . "ip -color=auto")
                             ("la" . "ls -la --color=auto")
                             ("ll" . "ls -l")
                             ("ls" . "ls -p --color=auto")))
                  (bashrc (list (local-file
                                 "/home/yaslam/src/guix-config/.bashrc"
                                 "bashrc")))
                  (bash-profile (list (local-file
                                       "/home/yaslam/src/guix-config/.bash_profile"
                                       "bash_profile")))))
	
	(simple-service 'my-env-vars-service
			home-environment-variables-service-type
			`(("GDK_DPI_SCALE" . "1.0")
			  ("BEANS" . "BEANSNMACHINES")
			  ("XDG_DATA_DIRS" . "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/yaslam/.local/share/flatpak/exports/share"))))))
