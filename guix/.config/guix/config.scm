;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu) (nongnu packages linux))
(use-modules (gnu services virtualization))
(use-modules (gnu services admin))
(use-package-modules base idutils)
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (kernel linux)
  (firmware (list linux-firmware))
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "guy-x")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "yaslam")
                  (comment "Yusef Aslam")
                  (group "users")
                  (home-directory "/home/yaslam")
                  (supplementary-groups '("wheel" "netdev" "audio" "video" "libvirt" "kvm")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "adwaita-icon-theme")
                          (specification->package "hicolor-icon-theme")
                     	  (specification->package "nss-certs")
			  (specification->package "ntfs-3g")
                          ;; (specification->package "kde-gtk-config")
			  ;; (specification->package "xdg-desktop-portal-kde")
                          (specification->package "iptables")
                          (specification->package "ebtables")
                          (specification->package "dnsmasq")
			  (specification->package "x11-ssh-askpass")
			  (specification->package "os-prober")
			  (specification->package "qemu")
                          (specification->package "gnome-shell-extensions")
                          (specification->package "glibc"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list 
	    ;; (service enlightenment-desktop-service-type)
	    ;; (service gnome-desktop-service-type)
	    ;; (service plasma-desktop-service-type)
	    ;; (service xfce-desktop-service-type)
            (service mate-desktop-service-type)

            ;; To configure OpenSSH, pass an 'openssh-configuration'
            ;; record as a second argument to 'service' below.
            (service openssh-service-type)
            (set-xorg-configuration
             (xorg-configuration (keyboard-layout keyboard-layout)))

	    (service libvirt-service-type
		     (libvirt-configuration
		      (unix-sock-group "libvirt")
		      (tls-port "16555")))

            (service virtlog-service-type
                     (virtlog-configuration
                      (max-clients 1000)))

	    (service unattended-upgrade-service-type))
           
           
           ;; This is the default list of services we
           ;; are appending to.
           (modify-services %desktop-services
			    (gdm-service-type config =>
					      (gdm-configuration
					       (wayland? #t))))))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss)
  
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                       (target (file-system-label "GUIXSWAP")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (file-system-label "GUIXEFI"))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
			 (device (file-system-label "GUIXROOT"))
                         (type "ext4"))
		       (file-system
			(mount-point "/mnt/GAMESNVMS")
			(device "/dev/sda4")
			(type "ext4"))
                       %base-file-systems)))
