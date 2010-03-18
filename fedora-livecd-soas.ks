# sugar-on-a-stick.ks
#
# Description:
# - A Sugar environment that you can carry in your pocket
#
# Maintainers:
# - Sebastian Dziallas <sdz AT fedoraproject DOT org>
# - Peter Robinson <pbrobinson AT gmail DOT com>

%include fedora-live-mini.ks

%packages

# core sugar platform
@sugar-desktop

# sugar activities
sugar-analyze
sugar-clock
sugar-connect
sugar-distance
sugar-finance
sugar-flipsticks
sugar-getiabooks
sugar-implode
sugar-infoslicer
sugar-maze
sugar-memorize
sugar-moon
sugar-physics
sugar-playgo
sugar-record
sugar-speak
sugar-stopwatch
sugar-tamtam-edit
sugar-tamtam-jam
sugar-tamtam-mini
sugar-tamtam-synthlab
sugar-typing-turtle
sugar-xoirc
sugar-visualmatch

# internet
alpine

# multimedia
csound-python
evince-djvu
gnash-plugin
gtk-recordmydesktop

# system
PackageKit-browser-plugin
gdm
gnome-power-manager
gnugo
gparted
gvfs
livecd-tools
xulrunner-python
zyx-liveinstaller

# hardware
b43-openfwwf
libertas-usb8388-firmware

# sound
alsa-plugins-pulseaudio
alsa-utils
gstreamer-plugins-good
gstreamer-plugins-espeak
gstreamer-plugins-bad-free
pulseaudio

# fonts
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

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=liveuser
FOE

EOF

%end
