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

%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages

# login
-gdm
-pulseaudio-gdm-hooks
lxdm

# Office
abiword

# Graphics
evince
-evince-dvi
-evince-djvu

# development
geany
vim-enhanced

# Internet
firefox
# Add the midori browser as a lighter alternative
midori
claws-mail
claws-mail-plugins-archive
claws-mail-plugins-att-remover
claws-mail-plugins-attachwarner
claws-mail-plugins-bogofilter
claws-mail-plugins-cachesaver
claws-mail-plugins-fetchinfo
claws-mail-plugins-mailmbox
claws-mail-plugins-newmail
claws-mail-plugins-notification
claws-mail-plugins-pgp
claws-mail-plugins-rssyl
claws-mail-plugins-smime
claws-mail-plugins-spam-report
claws-mail-plugins-tnef
claws-mail-plugins-vcalendar
liferea
pidgin
remmina
remmina-plugins-rdp
remmina-plugins-vnc
transmission

# multimedia
alsa-plugins-pulseaudio
asunder
cheese
quodlibet
pavucontrol
parole
parole-mozplugin
xfburn

# More Desktop stuff
# java plugin
java-1.6.0-openjdk-plugin
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-gnome
NetworkManager-pptp
catfish
desktop-backgrounds-compat
gcalctool
gparted
-gnome-disk-utility
gnome-bluetooth
xscreensaver
seahorse
setroubleshoot
xdg-user-dirs-gtk
# no longer required, but default theme in Xfce - cwickert 2011-02-11
gtk-theme-engine-clearlooks
# no longer required, but needed for compatibility - cwickert 2011-02-11
fedora-icon-theme
# Adwaita is now default - cwickert 2011-04-04
# https://bugzilla.redhat.com/show_bug.cgi?id=675509
adwaita-cursor-theme
adwaita-gtk2-theme
adwaita-gtk3-theme

# Command line
ntfs-3g
powertop
rtorrent
wget
irssi
mutt
yum-utils

# xfce packages
@xfce-desktop
Terminal
gtk-xfce-engine
orage
ristretto
hal-storage-addon
thunar-volman
thunar-media-tags-plugin
gigolo
xarchiver
xfce4-battery-plugin
# we already have thunar-volman
#xfce4-cddrive-plugin
xfce4-cellmodem-plugin
xfce4-clipman-plugin
xfce4-cpugraph-plugin
xfce4-datetime-plugin
xfce4-dict-plugin
xfce4-diskperf-plugin
xfce4-eyes-plugin
xfce4-fsguard-plugin
xfce4-genmon-plugin
xfce4-mailwatch-plugin
xfce4-mount-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-places-plugin
xfce4-power-manager
xfce4-quicklauncher-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-smartbookmark-plugin
# disabled for now, doesn't work with 4.8 - kevin 2011-01-14
#xfce4-stopwatch-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-time-out-plugin
xfce4-timer-plugin
xfce4-verve-plugin
# we already have nm-applet
#xfce4-wavelan-plugin
xfce4-weather-plugin
xfce4-websearch-plugin
# this one a compatibility layer for GNOME applets and depends on it
#xfce4-xfapplet-plugin
# requires gdm which we're not using in this build
#xfce4-xfswitch-plugin
xfce4-xkb-plugin
# system-config-printer does printer management better
#xfprint
xfwm4-themes

# dictionaries are big
-aspell-*
#-man-pages-*

# more fun with space saving
-gimp-help
# not needed, but as long as there is space left, we leave this in
#-desktop-backgrounds-basic

# save some space
-autofs
-nss_db
-acpid

# drop some system-config things
-system-config-boot
-system-config-language
-system-config-lvm
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

%end

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

# set up auto-login for liveuser
sed -i 's|# autologin=dgod|autologin=liveuser|g' /etc/lxdm/lxdm.conf

mkdir -p /root/.config/xfce4

cat > /root/.config/xfce4/helpers.rc <<EOF
MailReader=sylpheed-claws
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

mkdir -p /home/liveuser/.config/xfce4

cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
MailReader=sylpheed-claws
FileManager=Thunar
FOE

# disable screensaver locking (#674410)
cat >> /home/liveuser/.xscreensaver << FOE
mode:           off
lock:           False
dpmsEnabled:    False
FOE

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=60
FOE

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

