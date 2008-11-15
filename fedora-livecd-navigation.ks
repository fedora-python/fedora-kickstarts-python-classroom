# fedora-navigation.ks
#
# THIS IS ONLY A DRAFT !!!!
#
# Description:
# - Fedora Navigation Spin
#
# Maintainer(s):
# - Fabian Affolter <fab a fedoraproject.org>

%include fedora-live-base.ks

%packages
@graphical-internet
@graphics
@gnome-desktop
nss-mdns
NetworkManager-vpnc
NetworkManager-openvpn

# navigation tools
gpsbabel
gpsdrive
gpsd
gps-client
tangoGPS
#navit

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

# try to get down to cd sized
-gnumeric
-isdn4k-utils
-scim-bridge-gtk.i386
-dasher
-evince-dvi
-evince-djvu
-acpid
-ekiga
-tomboy
-f-spot

%end

%post
cat >> /etc/rc.d/init.d/fedora-live << EOF

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null

# set up timed auto-login for after 5 seconds
cat >> /etc/slim.conf << FOE
auto_login      yes
default_user    liveuser
FOE


# Download world map from OpenStreetMap project and include this map for navit
# Details: http://wiki.navit-project.org/index.php/OpenStreetMaps
# Map name
MAP_NAME = test_map
# Test area
wget -O $MAP_NAME.osm http://www.openstreetmap.org/api/0.5/map?bbox=11.4,48.7,11.6,48.9
cat $MAP_NAME.osm | ./osm2navit mymap.bin
# More than one map
# cat map1.osm map2.osm map3.osm | navit/src/osm2navit --dedupe-ways mymap.bin
# Europe allready as a bin file
# wget -O $MAP_NAME.bin http://maps.navit-project.org/api/map/?bbox=-12.963867187500007,33.59619140625,34.1455078125,72.09228515625

# Fedora Navigation doesn't need these and boots slowly
/sbin/chkconfig anacron off
/sbin/chkconfig sendmail off
/sbin/chkconfig nfs off
/sbin/chkconfig nfslock off
/sbin/chkconfig rpcidmapd off
/sbin/chkconfig rpcbind off


%end
