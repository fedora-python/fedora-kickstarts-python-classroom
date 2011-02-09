# fedora-livecd-kde.ks
#
# Description:
# - Fedora Livecd Spin with the K Desktop Environment (KDE)
#
# Maintainer(s):
# - Sebastian Vahl <fedora@deadbabylon.de>
# - Fedora KDE SIG, http://fedoraproject.org/wiki/SIGs/KDE, kde@lists.fedoraproject.org

%include fedora-live-kde-base.ks
%include fedora-live-minimization.ks


%packages
# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd
-amarok 			# amarok has duplicate functionality with juk (~13 megs)
-desktop-backgrounds-basic
-digikam			# digikam has duplicate functionality with gwenview (~11 megs)
-kdeaccessibility*
-kdeedu*			# kdeedu is too big for the live images
-scribus			# scribus is too big for the live images
-ktorrent			# kget has also basic torrent features (~3 megs)
-kaffeine*			# kaffeine has duplicate functionality with dragonplayer (~3 megs)
-kdeartwork-screensavers	# screensavers are not needed on live images
#-kipi-plugins			# ~8 megs
#-konq-plugins			# ~2 megs
#-kdeplasma-addons		# ~16 megs

# Additional packages that are not default in kde-desktop but useful
k3b				# ~15 megs
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
