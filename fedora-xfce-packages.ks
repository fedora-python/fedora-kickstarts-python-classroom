# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <cwickert@fedoraproject.org>
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@fedoraproject.org>


%packages

@networkmanager-submodules
@xfce-desktop
@xfce-apps
@xfce-extra-plugins
@xfce-media
@xfce-office

# unlock default keyring. FIXME: Should probably be done in comps
gnome-keyring-pam

# save some space
-autofs
-pidgin
-acpid
-gimp-help
-desktop-backgrounds-basic
-realmd                     # only seems to be used in GNOME
-PackageKit*                # we switched to yumex, so we don't need this
-aspell-*                   # dictionaries are big
-gnumeric
-foomatic-db-ppds
-foomatic
-gutenprint
-gutenprint-cups
-stix-fonts
-ibus-typing-booster
-xfce4-sensors-plugin
#-man-pages-*
-adobe-source-han-* # save 94MB
-rodent-icon-theme  # save 34MB
-skkdic             # save 25MB
-naver-nanum-gothic-fonts # save 14MB
-ibus-kkc
-ibus-libpinyin
-libpinyin-data
-libkkc-data
# Drop some fonts for space
-vlgothic-fonts
-paratype-pt-sans-fonts
-jomolhari-fonts
-sil-abyssinca-fonts

# drop some system-config things
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

%end
