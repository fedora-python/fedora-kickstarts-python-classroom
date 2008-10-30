# fedora-livecd-desktop-en_US.ks
#
# Maintainer(s):
# - UNKNOWN

%include fedora-livecd-desktop.ks

lang en_US.UTF-8
keyboard us
timezone US/Eastern

%packages
# exclude input methods
-m17n*
-scim*
%end
