# fedora-livecd-xfce-fr_FR.ks
#
# Description:
# - French Fedora Live Spin with the Xfce Desktop Environment
#
# Maintainer(s):
# - Matthieu Saulnier <fantom@fedoraproject.org>

%include ../fedora-livecd-xfce.ks

lang fr_FR.UTF-8
keyboard fr-latin9
timezone Europe/Paris

%packages
@french-support
aspell-fr
hunspell-fr
libreoffice-langpack-fr
# exclude input methods:
-m17n*
-scim*
-ibus*
-iok
%end
