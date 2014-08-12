%packages
@firefox
@gnome-desktop
@libreoffice
@networkmanager-submodules

# Workstation specific package
firewalld-config-workstation

#QT
qt
qt-settings
qt-x11
qt5-qtbase
qt5-qtbase-gui
qt5-qtdeclarative
qt5-qtxmlpatterns

devassistant
scl-utils

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @standard
-smartmontools

# We use gnome-control-center's printer and input sources panels instead
-system-config-printer
-im-chooser

-aisleriot
-baobab
-biosdevname
-coolkey
-deja-dup
-dtc
-dump
-ed
-finger
-ftp
-gc
-gfs2-utils
-gnu-free-fonts-common
-gnu-free-mono-fonts
-gnu-free-sans-fonts
-gnu-free-serif-fonts
-gtk2-immodule-xim
-gtk3-immodule-xim
-gtkmm24
-guile
-imsettings*
-irda-utils
-irqbalance
-isdn4k-utils
-kernel-modules-extra
-lftp
-linux-atm
-minicom
-nano
-ntsysv
-numactl
-reiserfs-utils
-rsh
-tagsoup
-talk
-telnet
-uboot-tools
-xl2tpd
-NetworkManager-l2tp

%end
