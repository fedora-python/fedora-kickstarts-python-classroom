# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <cwickert@fedoraproject.org>
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@gmail.com>

%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages

# Office
abiword
gnumeric

# Graphics
evince
-evince-dvi
-evince-djvu
gimp
inkscape

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
gnome-bluetooth
xscreensaver
seahorse
setroubleshoot
xdg-user-dirs-gtk

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
xfce4-remmina-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-smartbookmark-plugin
xfce4-stopwatch-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-time-out-plugin
xfce4-timer-plugin
xfce4-verve-plugin
xfce4-volstatus-icon
# we already have nm-applet
#xfce4-wavelan-plugin
xfce4-weather-plugin
xfce4-websearch-plugin
# this one a compatibility layer for GNOME applets and depends on it
#xfce4-xfapplet-plugin
xfce4-xfswitch-plugin
xfce4-xkb-plugin
# system-config-printer does printer management better
#xfprint
xfwm4-themes

# dictionaries are big
#-aspell-*
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
EOF

mkdir -p /root/.config/xfce4

cat > /root/.config/xfce4/helpers.rc <<EOF
MailReader=sylpheed-claws
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

mkdir -p /home/liveuser/.config/xfce4

cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
MailReader=sylpheed-claws
FOE

# disable screensaver locking
cat >> /home/liveuser/.xscreensaver << FOE
lock:	False
FOE
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

