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
pavucontrol
lxmusic
asunder
gxine
gxine-mozplugin

# I'm looking for something smaller than
gnomebaker

# development
#geany

# More Desktop stuff
xdg-user-dirs
@java
alsa-plugins-pulseaudio
NetworkManager-gnome
galculator
xpad
cups-pdf

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

%end

%post
# LXDE and SLiM configuration

# create /etc/sysconfig/desktop (needed for installation)

cat >> /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startlxde
DISPLAYMANAGER=/usr/bin/slim-dynwm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

# set up timed auto-login for after 60 seconds
cat >> /etc/slim.conf << FOE
auto_login	yes
default_user	liveuser
FOE

EOF

%post

%end

