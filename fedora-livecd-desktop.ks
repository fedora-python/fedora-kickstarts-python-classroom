# Desktop with customizationst to fit in a CD sized image (package removals, etc.)
# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:fedora-desktop-list@fedoraproject.org

%include fedora-live-desktop.ks
%include fedora-live-minimization.ks

%packages
# First, no office.
-openoffice.org-*

# Temporary list of things removed from comps but not synced yet
-specspo
-xsane

# Drop the Java plugin
-java-1.6.0-openjdk-plugin
-java-1.6.0-openjdk

# No printing
-foomatic-db-ppds

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages*
-words

# save some space
-gnome-user-docs
-evolution-help
-gnome-games-help
-nss_db
-isdn4k-utils
-desktop-backgrounds-basic
-constantine-backgrounds-extras
-seahorse
-alacarte
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
-telnet
-unix2dos
-nfs-utils
-ypbind
-yp-tools
-rpcbind

# drop some system-config things
-system-config-boot
-system-config-language
-system-config-network
-system-config-rootpassword
-system-config-services
-policycoreutils-gui
%end
