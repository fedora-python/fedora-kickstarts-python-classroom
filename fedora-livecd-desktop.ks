# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:fedora-desktop-list@redhat.com

# NOTE!
#
# This kickstart file is non-branded to facilitate doing test spins
# without trademark complications. You NEED to remove the debranding
# lines below when doing official spins.

%include fedora-live-base.ks

%packages
@games
@graphical-internet
@graphics
@sound-and-video
@gnome-desktop
nss-mdns
NetworkManager-vpnc
NetworkManager-openvpn
# we don't include @office so that we don't get OOo.  but some nice bits
abiword
#gnumeric
#planner
#inkscape

# avoid weird case where we pull in more festival stuff than we need
festival
festvox-slt-arctic-hts

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages*
-words

# save some space
-gnome-user-docs
-gimp-help
-gimp-help-browser
-gimp-data-extras
-evolution-help
-gnome-games
-gnome-games-help
-nss_db
-vino
-isdn4k-utils
-dasher
-evince-dvi
-evince-djvu
-krb5-auth-dialog
-alacarte
# not needed for gnome
-acpid
-wget

# these pull in excessive dependencies
-ekiga
-tomboy
-f-spot

# drop some system-config things
-system-config-boot
-system-config-language
-system-config-lvm
-system-config-network
-system-config-rootpassword
-system-config-services
-policycoreutils-gui

# use the PackageKit helper for bash
PackageKit-command-not-found

# debrand test spins. Remove this for official releases !
-fedora-logos
generic-logos

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=60
FOE

EOF

%end
