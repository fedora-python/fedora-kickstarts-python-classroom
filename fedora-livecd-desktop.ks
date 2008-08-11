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
gnumeric
#planner
#inkscape

# avoid weird case where we pull in more festival stuff than we need
festival
festvox-slt-arctic-hts

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-scim-tables-*
-wqy-bitmap-fonts
-dejavu-fonts-experimental

# more fun with space saving
-scim-lang-chinese
-scim-python*
scim-chewing
scim-pinyin

# save some space
-gnome-user-docs
-gimp-help
-evolution-help
-autofs
-nss_db
-vino

-dasher
-evince-dvi
-evince-djvu
# not needed for gnome
-acpid
# temporary - drags in many deps
-ekiga
-tomboy
-f-spot

# try to get down to cd sized for the alpha
-gnumeric
-isdn4k-utils
# hack to deal with conditionals + multiarch blargh
-scim-bridge-gtk.i386
%end

%post
cat >> /etc/rc.d/init.d/fedora-live << EOF
# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=fedora
TimedLoginDelay=60
FOE

EOF

%end
