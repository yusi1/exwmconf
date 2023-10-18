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
                          (specification->package "sway")
			  (specification->package "ntfs-3g")
                          (specification->package "kde-gtk-config")
			  (specification->package "xdg-desktop-portal-kde")
                          (specification->package "iptables")
                          (specification->package "ebtables")
                          (specification->package "dnsmasq"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list 
	    ;; (service enlightenment-desktop-service-type)
	    ;; (service gnome-desktop-service-type)
	    (service plasma-desktop-service-type)
	    ;; (service xfce-desktop-service-type)
            ;; (service mate-desktop-service-type)

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
                      (max-clients 1000))))
           
           
           ;; This is the default list of services we
           ;; are appending to.
           (modify-services %desktop-services
			    (gdm-service-type config =>
					      (gdm-configuration
					       (wayland? #t))))))
  
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "a79ba3b2-3ee9-41de-8a80-8cb569e7bc2e")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "97FD-1C3C"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "4cf3d2e7-5b01-48ac-af32-ec8fd0baf972"
                                  'ext4))
                         (type "ext4"))
		       ;; (file-system
		       ;; 	(mount-point "/mnt/GAMESNVMS")
		       ;; 	(device "/dev/sda1")
		       ;; 	(type "ntfs-3g"))
                       %base-file-systems)))
