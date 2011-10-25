# Maintained by the Fedora Robotics SIG:
# http://fedoraproject.org/wiki/SIGs/Robotics
# mailto:robotics@lists.fedoraproject.org

%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages
# Start with GNOME
@gnome-desktop

# Add robotics development
@robotics-suite
-fawkes*
player-devel
stage-devel
mrpt-devel

# Remove gnome-y things
-@graphical-internet
-@games
-@sound-and-video

firefox

# No Office
-libreoffice-*
-planner

# Drop the Java plugin
-icedtea-web
-java-1.6.0-openjdk

# Drop things that pull in perl
-linux-atm
-perf

# No printing
-foomatic-db-ppds
-foomatic

# Dictionaries are big
-aspell-*
-hunspell-*
-man-pages*
-words

# Help and art can be big, too
-gnome-user-docs
-evolution-help
-gnome-games-help
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
-telnet
-nfs-utils
-ypbind
-yp-tools
-rpcbind
-acpid
-ntsysv

# Drop some system-config things
-system-config-boot
-system-config-language
-system-config-network
-system-config-rootpassword
-system-config-services
-policycoreutils-gui

%end

%post
%end
