# Desktop with customizations to fit in a CD (package removals, etc.)
# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include fedora-live-mate_compiz.ks
%include fedora-live-minimization.ks

%packages
# First, no office
-planner

# Drop things for size
-@3d-printing
-brasero
-bluez
-bluez-cups
-@dial-up
-dnf
-gnome-bluetooth-libs
-gnome-icon-theme-symbolic
-gnome-software
-gnome-user-docs
-@guest-desktop-agents
-@libreoffice
-@mate-applications
-mate-icon-theme-faenza
-transmission-gtk
-samba-client
-gnome-themes
-fedora-icon-theme
-espeak
-gstreamer-plugins-espeak
-ibus-typing-booster
-ibus-kkc
-libkkc
-libkkc-data        #save 30MB
-skkdic             # save 25MB
-ibus-libpinyin
-libpinyin
-libpinyin-data     #save 31MB
-colord

# Drop oversized fonts that aren't needed
-adobe-source-han-* # save 94MB
-naver-nanum-gothic-fonts # save 14MB
-stix-fonts
-vlgothic-fonts
-paratype-pt-sans-fonts
-jomolhari-fonts
-sil-abyssinica-fonts

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
-system-config-rootpassword
-system-config-services
-policycoreutils-gui

%end

%post
# This is a huge file and things work ok without it
rm -f /usr/share/icons/HighContrast/icon-theme.cache

%end
