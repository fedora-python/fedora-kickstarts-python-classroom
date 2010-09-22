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

part / --size=2048

%packages

# == Core Sugar Platform ==
sugar

# == Platform Components ==
# from http://wiki.sugarlabs.org/go/0.88/Platform_Components
alsa-plugins-pulseaudio
alsa-utils
etoys
csound-python
evince-djvu
gstreamer-plugins-good
gstreamer-plugins-espeak
gstreamer-plugins-bad-free
pygame
pulseaudio
pulseaudio-utils

# == Sugar Activities ==
sugar-browse # Because they need this to install activities.
sugar-log # Because they need this for debugging.
sugar-physics # Because this is a great demo example (quick demo).
sugar-terminal # Because this makes debugging easier.
sugar-turtleart # Because this is a great demo example (extended demo).
sugar-xoirc # Because this helps us help them.
sugar-chat
sugar-record
sugar-write
etoys-sugar
sugar-pippy
sugar-calculator
sugar-speak

# Write breaks unless we do this (we don't need it anyway)
-@input-methods

# == Activities from ASLO ==
# These are activities we're going to polish to the same level
# as the ones included in the SoaS image, but encourage people
# to download from ASLO as part of the SoaS experience of exploring
# other Activities in there.

# sugar-maze
# sugar-speak
# sugar-tamtam-*
# sugar-visualmatch

# These are Activities that aren't quite there, but are important,
# so we're going to encourage people to test them.

# sugar-pippy
# sugar-read

# == System ==
# Automatically logs in the liveuser
# We're going to replace this with nodm
# http://bugs.sugarlabs.org/ticket/1849
gdm

# Needed to show external hard drives
gvfs

# Needed for battery monitoring and power management
gnome-power-manager

# Usefulness for DSL connections as per:
# http://bugs.sugarlabs.org/ticket/1951
rp-pppoe
# Useful for SoaS duplication from:
# http://bugs.sugarlabs.org/ticket/74
livecd-tools

# Get the Sugar boot screen
-plymouth-system-theme
-plymouth-theme-charge
sugar-logos

# == Hardware ==
# Lets support Broadcom and XO wifi hardware
b43-openfwwf
libertas-usb8388-firmware

# == Fonts ==
# More font support according to:
# http://bugs.sugarlabs.org/ticket/1119
# Moved to mini.ks

%end

%post

# Rebuild initrd for Sugar boot screen
KERNEL_VERSION=$(rpm -q kernel --qf '%{version}-%{release}.%{arch}\n')
/usr/sbin/plymouth-set-default-theme sugar
/sbin/dracut -f /boot/initramfs-$KERNEL_VERSION.img $KERNEL_VERSION

# Get proper release naming in the control panel
cat >> /boot/olpc_build << EOF
Sugar on a Stick 4 (Mango Lassi)
Fedora 14 (Laughlin)
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# Don't use the default system user (in SoaS liveuser) as nick name
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /desktop/sugar/user/default_nick disabled >/dev/null

# Disable the logout menu item in Sugar
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/sugar/show_logout false >/dev/null

# Enable Sugar power management
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/sugar/power/automatic True >/dev/null

# Add our activities to the favorites
cat > /usr/share/sugar/data/activities.defaults << FOE
org.laptop.AbiWordActivity
org.laptop.Chat
org.laptop.Log
org.laptop.physics
org.laptop.RecordActivity
org.laptop.Terminal
org.laptop.TurtleArtActivity
org.laptop.WebActivity
org.laptop.Pippy
org.laptop.Calculator
org.laptop.Speak
org.sugarlabs.IRC
org.vpri.EtoysActivity
FOE

# Set up auto-login for for liveuser
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=liveuser
FOE

EOF

%end
