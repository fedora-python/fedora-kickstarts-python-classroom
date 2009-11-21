# fedora-livecd-lxde.ks
#
# Description:
# - Fedora Live Spin with the light-weight LXDE Desktop Environment
#
# Maintainer(s):
# - Christoph Wickert <cwickert@fedoraproject.org>

%include fedora-live-base.ks

%packages
# LXDE desktop
@lxde-desktop
lxlauncher
obconf
parcellite
slim

# internet
midori
sylpheed
lostirc
transmission
gftp

# office
abiword
gnumeric
osmo
#glista

# graphics
epdfview
mtpaint

# audio & video
gmixer
lxmusic
asunder
gxine
gxine-mozplugin

# I'm looking for something smaller than
gnomebaker

# development
#geany

# More Desktop stuff
xdg-user-dirs-gtk
#@java
alsa-plugins-pulseaudio
NetworkManager-gnome
galculator
xpad
xcompmgr

# make sure kpackagekit doesn't end up the LXDE live images
gnome-packagekit*
-kpackagekit

# make sure polkit-qt doesn't end up the LXDE live images
# this is not yet in rawide
#polkit-gnome
#-polkit-qt

# same for Fedora <= 11, but commented out
PolicyKit-gnome
-PolicyKit-kde

# make sure xfce4-notifyd is not pulled in
-xfce4-notifyd
notification-daemon

# use yumex instead of gnome-packagekit
#-gnome-packagekit
#yumex

# Command line
powertop
wget
yum-utils
yum-presto

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-words

# save some space
-nss_db
-sendmail
ssmtp
-acpid

# drop some system-config things
-system-config-boot
#-system-config-language
-system-config-lvm
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

%end

%post
# LXDE and SLiM configuration

# create /etc/sysconfig/desktop (needed for installation)

cat >> /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startlxde
DISPLAYMANAGER=/usr/bin/slim-dynwm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
rm -f /etc/xdg/lxsession/LXDE/autostart
cat >> /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxde-settings-daemon
@pulseaudio -D
@lxpanel --profile LXDE
@pcmanfm -d
FOE

# set up auto-login for liveuser
cat >> /etc/slim.conf << FOE
auto_login		yes
default_user	liveuser
FOE

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# Add autostart for parcellite
cp /usr/share/applications/fedora-parcellite.desktop /etc/xdg/autostart

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

