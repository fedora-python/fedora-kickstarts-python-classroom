# Maintained by the Fedora Mini SIG:
# https://fedoraproject.org/wiki/SIGs/FedoraMini

%include fedora-live-mini.ks

%packages

# moblin desktop
@moblin-desktop
mesa-dri-drivers-experimental
notification-daemon
gnome-terminal
empathy
gypsy
geoclue-gypsy
firefox

# Some useful gnome tools
cheese
nautilus

# display managers
gdm
#uxlaunch

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
# make sure the fonts are not too big
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t int /desktop/gnome/font_rendering/dpi 120 >/dev/null

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=60
FOE

EOF

%end
