# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <chris@christoph-wickert.de>
# - Kevin Fenzi       <kevin@tummy.com>

%include fedora-live-base.ks

%packages

# gdm depends on gnome-session but lacks a dependency. Temporary workaround

gnome-session

firefox
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-gnome
NetworkManager-pptp

#nss-mdns

# we don't include @office so that we don't get OOo.  but some nice bits

abiword
gnumeric

evince
-evince-dvi
-evince-djvu

gimp
inkscape

galculator
desktop-backgrounds-compat
gnome-screensaver
setroubleshoot

# development
geany

# More Desktop stuff
xdg-user-dirs
@java
totem
totem-mozplugin
pidgin
claws-mail
# brasero has more dependencies
gnomebaker
drivel
liferea
quodlibet
gftp
ristretto
asunder
tracker-search-tool

gnome-power-manager
seahorse
transmission
cups-pdf
bluez-gnome
alsa-plugins-pulseaudio
pavucontrol

# Command line
ntfs-3g
powertop
wget
irssi
mutt
yum-utils

# xfce packages
@xfce-desktop
gtk-xfce-engine
orage
thunar-volman
xarchiver
xfce4-battery-plugin
xfce4-clipman-plugin
xfce4-cpugraph-plugin
xfce4-datetime-plugin
xfce4-dict-plugin
xfce4-diskperf-plugin
xfce4-genmon-plugin
#redundant with verve plugin
#xfce4-minicmd-plugin
xfce4-mount-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-places-plugin
xfce4-quicklauncher-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-volstatus-icon
xfce4-verve-plugin
# We use NetworkManager-gnome. So this is redundant
xfce4-weather-plugin
xfce4-websearch-plugin
# this one a compatibility layer for GNOME applets and depends on it
#xfce4-xfapplet-plugin
xfwm4-themes

# dictionaries are big
#-aspell-*
#-man-pages-*
#-scim-tables-*

# more fun with space saving
#-scim-lang-chinese
#scim-chewing
#scim-pinyin
-gimp-help


# save some space
-autofs
-nss_db
-sendmail
ssmtp
-acpid
# system-config-printer does printer management better
# xfprint has now been made as optional in comps.
system-config-printer
%end

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
EOF

mkdir -p /home/fedora/.config/tracker

cat > /home/fedora/.config/tracker/tracker.cfg <<EOF
[Indexing]
EnableIndexing=false
Language=en
EOF

mkdir -p /root/.config/tracker
cat > /root/.config/tracker/tracker.cfg <<EOF
[Indexing]
EnableIndexing=false
Language=en
EOF

cat >> /etc/rc.d/init.d/fedora-live << EOF
chown -R fedora:fedora /home/fedora

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


%post

# remove this session file from gnome-session package to make xfce the default
# temporary hack till this file is split up from the package

rm -rf /usr/share/xsessions/gnome.desktop

%end

