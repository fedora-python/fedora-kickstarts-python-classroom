# fedora-livecd-kde-fr_FR.ks
#
# Description:
# - French Fedora Live Spin with the KDE Desktop Environment
#
# Maintainer(s):
# - Matthieu Saulnier <fantom@fedoraproject.org>

%include ../fedora-livecd-kde.ks

lang fr_FR.UTF-8
keyboard fr-latin9
timezone Europe/Paris

%packages
@french-support
# exclude input methods:
-m17n*
-scim*
-ibus*
-iok
%end
