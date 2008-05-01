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
evince
gnome-blog
#planner
#inkscape

# dictionaries are big
-aspell-*
-man-pages-*
-scim-tables-*
-wqy-bitmap-fonts
-dejavu-fonts-experimental
-dejavu-fonts

# more fun with space saving
-scim-lang-chinese
scim-chewing
scim-pinyin

# save some space
-gnome-user-docs
-gimp-help
-evolution-help
-autofs
-nss_db
-vino

%end

%post
cat >> /etc/rc.d/init.d/fedora-live << EOF
# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# set up timed auto-login for after 60 seconds
sed -i -e 's/\[daemon\]/[daemon]\nTimedLoginEnable=true\nTimedLogin=fedora\nTimedLoginDelay=60/' /etc/gdm/custom.conf
if [ -e /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png ] ; then
    cp /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png /home/fedora/.face
    chown fedora:fedora /home/fedora/.face
    # TODO: would be nice to get e-d-s to pick this one up too... but how?
fi

EOF

%end
