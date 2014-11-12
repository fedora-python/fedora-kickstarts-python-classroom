# Desktop with customizations to fit in a CD (package removals, etc.)
# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include fedora-live-mate_compiz.ks
%include fedora-live-minimization.ks

%packages

# audio player
audacious

# First, no office
-planner

# Drop things for size
-@3d-printing
-brasero
-bluez
-bluez-cups
-caja-image-converter
-colord
-compiz-plugins-extra
-compiz-plugins-unsupported
-@dial-up
-espeak
-fedora-icon-theme
-GConf2
-gnome-bluetooth-libs
-gnome-icon-theme
-gnome-icon-theme-symbolic
-gnome-software
-gnome-themes
-gnome-user-docs
-gstreamer1-plugins-good
-gstreamer1-plugins-bad-free
-gstreamer-plugins-good
-gstreamer-plugins-bad-free
-gstreamer-plugins-espeak
-gucharmap
-@guest-desktop-agents
-@libreoffice
-lftp
-@mate-applications
-mate-icon-theme-faenza
-NetworkManager-bluetooth
-transmission-gtk
-samba-client
-ibus-chewing
-ImageMagick
-ImageMagick-libs
-libical
-OpenEXR-libs
-reiserfs-utils
-seahorse
-vim-common
-vim-enhanced

# Drop oversized fonts that aren't needed
-gnu-free-mono-fonts
-gnu-free-fonts-common
-gnu-free-serif-fonts
-gnu-free-sans-fonts
-stix-fonts

# Drop the Java plugin
-icedtea-web
-java-1.8.0-openjdk

# Drop things that pull in perl
-linux-atm

# No printing
-foomatic-db-ppds
-foomatic
-gutenprint
-gutenprint-cups
-gutenprint-libs
-cups
-cups-filters
-cups-pk-helper

# Dictionaries are big
# we're going to try keeping hunspell-* after notting, davidz, and ajax voiced
# strong preference to giving it a go on #fedora-desktop.
# also see http://bugzilla.gnome.org/681084
-aspell-*
-man-pages*
-words

# Help and art can be big, too
-gnome-user-docs
-evolution-help
-desktop-backgrounds-basic
-*backgrounds-extras

# Legacy cmdline things we don't want
-krb5-auth-dialog
-krb5-workstation
-pam_krb5
-quota
-nano
-minicom
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-nfs-utils
-ypbind
-yp-tools
-rpcbind
-acpid
-ntsysv

# Drop some system-config things
-system-config-language
-system-config-printer
-system-config-printer-libs
-system-config-printer-udev
-system-config-rootpassword
-system-config-services
-system-config-users
-policycoreutils-gui

%end

%post
# This is a huge file and things work ok without it
rm -f /usr/share/icons/HighContrast/icon-theme.cache

%end
