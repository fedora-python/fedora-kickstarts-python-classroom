# fedora-live-kde.ks
#
# Description:
# - Fedora Live Spin with the K Desktop Environment (KDE), 1 GiB version
#   see fedora-livecd-kde.ks for the default CD-sized version
#
# Maintainer(s):
# - Sebastian Vahl <fedora@deadbabylon.de>
# - Fedora KDE SIG, http://fedoraproject.org/wiki/SIGs/KDE, kde@lists.fedoraproject.org

%include fedora-live-kde-base.ks
%include fedora-live-minimization.ks


%packages
# ship KDE wallpapers instead of GNOME ones
-desktop-backgrounds-basic
kdebase-workspace-wallpapers

# Additional packages that are not default in kde-desktop but useful
-koffice-suite			# don't include whole koffice-suite, just parts of it
koffice-kword
koffice-kspread			# ~1 megs
koffice-kpresenter		# ~3 megs
koffice-filters
#kdeartwork			# only include some parts of kdeartwork
#twinkle			# (~10 megs)
fuse
liveusb-creator
#pavucontrol			# nice to have but pulls in gstreamer (~3 megs)
fpaste				# user request and pretty small

# only include kdegames-minimal
-kdegames
kdegames-minimal

# use system-config-printer-kde instead of system-config-printer
-system-config-printer
system-config-printer-kde

# use yum-presto by default
yum-presto

### fixes and space issues

# fonts (we make no bones about admitting we're english-only)
wqy-microhei-fonts	# a compact CJK font
-un-core-dotum-fonts
-vlgothic-fonts
-wqy-zenhei-fonts
-paratype-pt-sans-fonts
#-stix-fonts		# mathematical symbols
#-kacst*fonts*		# arabic

# make sure alsaunmute is there
alsa-utils

# make sure gnome-packagekit doesn't end up the KDE live images
-gnome-packagekit*

# remove input methods to free space
-@input-methods
-scim*
-m17n*
-ibus*
-iok

# save some space (from @base)
-make
-nss_db

## avoid serious bugs by omitting broken stuff

%end

%post
%end
