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
dates
contacts
tasks

# telepathy IM protocols
telepathy-salut
telepathy-sofiasip
telepathy-gabble
telepathy-farsight
telepathy-butterfly

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
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/gnome/lockdown/disable_lock_screen true >/dev/null

# Set up auto-login for for liveuser
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=liveuser
FOE

# Add favourite apps to MyZone
cat > /home/liveuser/.local/share/favourite-apps << FOE
file:///usr/share/applications/moblin-app-installer.desktop file:///usr/share/applications/anjal.desktop file:///usr/share/applications/mozilla-firefox.desktop file:///usr/share/applications/fedora-empathy.desktop file:///usr/share/applications/hornsey.desktop file:///usr/share/applications/fedora-dates.desktop file:///usr/share/applications/fedora-contacts.desktop file:///usr/share/applications/fedora-tasks.desktop
FOE

# Turn off PackageKit-command-not-found while uninstalled
sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf

EOF

%end
