# fedora-livedvd-games-pt_PT.ks
#
# Maintainer(s):
# - Pedro Silva <pedrofsilva a netcabo.pt>

%include fedora-livedvd-games.ks

lang pt_PT.UTF-8
keyboard pt-latin1
timezone Europe/Lisbon

%packages
@portuguese-support
%end

%post
# system-config-keyboard doesn't really work (missing xorg.conf etc)
cat >>/etc/X11/xorg.conf << EOF
Section "InputDevice"
    Identifier "Keyboard0"
    Driver "kbd"
    Option "XkbLayout" "pt"
EndSection
EOF
%end
