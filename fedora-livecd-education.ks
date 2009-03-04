# fedora-livecd-education.ks
#
# Description:
# - Fedora Live Spin including mainly software for educational purposes
#
# Maintainers:
# - Sebastian Dziallas <sdz AT fedoraproject DOT org>
# - Fedora Education SIG

%include fedora-live-base.ks

# please don't forget to adjust the instLangs argument
# if you are going to create a localized spin
%packages --excludedocs --instLangs en_US

# desktop environments
@sugar-desktop
@xfce-desktop

# education
avogadro
kdeedu

# internet
alpine
empathy
firefox

# office
abiword
gnumeric
evince

# graphics
blender
inkscape
gimp
mirage

# audio & video
totem
totem-gstreamer
totem-mozplugin
-totem-xine
-xine-lib

# others
geany
gnash-plugin

# system
alsa-plugins-pulseaudio
desktop-backgrounds-compat
gnome-power-manager
liveusb-creator
NetworkManager-gnome
pavucontrol
setroubleshoot
xdg-user-dirs

# remove imsettings-xfce for now until it gets re-written
-imsettings-xfce

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-words

# exclude input methods
-scim*
-m17n*

# save some space
-autofs
-nss_db
-sendmail
ssmtp
-acpid
-isdn4k-utils
-gimp-help
-gimp-help-browser

%post

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
chown -R liveuser:liveuser /home/liveuser

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
