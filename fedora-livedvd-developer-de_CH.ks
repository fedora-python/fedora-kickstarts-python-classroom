# fedora-livedvd-developer-de_CH.ks
#
# Maintainer(s):
# - Fabian Affolter  <fab a fedoraproject.org>

%include fedora-livedvd-developer.ks

lang de_DE
keyboard sg-latin1
timezone Europe/Zurich

%packages
@german-support
%end

%post
# system-config-keyboard doesn't really work (missing xorg.conf etc)
cat >>/etc/X11/xorg.conf << EOF
Section "InputDevice"
    Identifier "Keyboard0"
    Option	    "XkbLayout" "ch"
    Option	    "XkbVariant" "de_nodeadkeys"
EndSection
EOF
%end
