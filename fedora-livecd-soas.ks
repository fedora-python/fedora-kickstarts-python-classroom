# fedora-livecd-soas.ks
#
# Description:
# - A Sugar environment that you can carry in your pocket
#
# Maintainers:
# - Sebastian Dziallas <sdz AT fedoraproject DOT org>
# - Peter Robinson <pbrobinson AT gmail DOT com>
# - Mel Chua <mchua AT fedoraproject DOT org>

%include fedora-live-mini.ks

%packages

# == core sugar platform ==
sugar

# == platform components ==
# from http://wiki.sugarlabs.org/go/0.88/Platform_Components
alsa-plugins-pulseaudio
alsa-utils
etoys
csound-python
evince-djvu
gstreamer-plugins-good
gstreamer-plugins-espeak
gstreamer-plugins-bad-free
pulseaudio

# == sugar activities ==
sugar-browse # Because they need this to install activities.
sugar-log # Because they need this for debugging.
sugar-terminal # Because this makes debugging easier.
sugar-turtleart # Because this is a great demo example (extended demo).
sugar-xoirc # Because this helps us help them.

# == Activities from ASLO ==
# These are activities we're going to polish to the same level
# as the ones included in the SoaS image, but encourage people
# to download from ASLO as part of the SoaS experience of exploring
# other Activities in there.

# etoys-sugar
# sugar-maze
# sugar-speak
# sugar-tamtam-*
# sugar-visualmatch

# These are Activities that aren't quite there, but are important,
# so we're going to encourage people to test them.

# sugar-write
# sugar-record
# sugar-pippy
# sugar-read

# == system ==
# automatically logs in the liveuser
# replace this with nodm for v4
# http://bugs.sugarlabs.org/ticket/1849
gdm

# needed to show external hard drives
gvfs

# needed for battery monitoring and power management in sugar
gnome-power-manager

# we can haz sugar boot screen
-plymouth-system-theme
-plymouth-theme-charge
sugar-logos

# == hardware ==
# lets support broadcom and xo wifi hardware
b43-openfwwf
libertas-usb8388-firmware

# == fonts ==
# more font support
# http://bugs.sugarlabs.org/ticket/1119
google-droid-fonts-common
google-droid-sans-fonts
google-droid-sans-mono-fonts
google-droid-serif-fonts

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF

# don't use the default system user (in soas liveuser) as nick name
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /desktop/sugar/user/default_nick disabled >/dev/null

# disable the logout menu item in Sugar
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/sugar/show_logout false >/dev/null

# set sugar power management on
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/sugar/power/automatic True >/dev/null

# add our activities to the favorites
cat > /usr/share/sugar/data/activities.defaults << FOE
org.laptop.WebActivity
org.laptop.Log
org.laptop.physics
org.laptop.Terminal
org.laptop.TurtleArtActivity
org.sugarlabs.IRC
FOE

# set up auto-login for for liveuser
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=liveuser
FOE

EOF

%end
