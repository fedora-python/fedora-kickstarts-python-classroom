# fedora-livecd-kde-pt_PT.ks
#
# Maintainer(s):
# - Pedro Silva <pedrofsilva a netcabo.pt>

%include fedora-livecd-kde.ks

lang pt_PT.UTF-8
keyboard pt-latin1
timezone Europe/Lisbon

%packages
@portuguese-support

%end

%post
# set up localized keyboard since it is not used in /etc/X11/xorg.conf anymore and
# KDE don't use /etc/sysconfig/keyboard.
# Replace "de-latin1-nodeadkeys" with the keyboard layout you have used above
mkdir -p /home/liveuser/.kde/env
echo "system-config-keyboard --noui de-latin1-nodeadkeys" > /home/liveuser/.kde/env/keyboard.sh
chmod +x /home/liveuser/.kde/env/keyboard.sh
chown -R fedora:fedora /home/liveuser/.kde/env/
%end
