# fedora-livecd-kde.ks
#
# Description:
# - Fedora Live Spin with the K Desktop Environment (KDE)
#
# Maintainer(s):
# - Sebastian Vahl <fedora@deadbabylon.de>
# - Fedora KDE SIG

%include fedora-live-base.ks
%include fedora-live-minimization.ks

%packages

### The KDE-Desktop

@kde-desktop

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd
-amarok 			# amarok has duplicate functionality with juk (~13 megs)
-digikam			# digikam has duplicate functionality with gwenview (~11 megs)
-kdeedu*			# kdeedu is too big for the live images
-scribus			# scribus is too big for the live images
-ktorrent			# kget has also basic torrent features (~3 megs)
-kftpgrabber*			# konqueror is also able to browse ftp shares, requires kdelibs3
-kaffeine*			# kaffeine has duplicate functionality with dragonplayer (~3 megs)
-kdeartwork-screensavers	# screensavers are not needed on live images
-kipi-plugins			# ~8 megs
#-konq-plugins			# ~2 megs
#-kdeplasma-addons		# ~16 megs

# Additional packages that are not default in kde-desktop but useful
-koffice-suite			# don't include whole koffice-suite, just parts of it
koffice-kword
koffice-kspread			# ~1 megs
koffice-kpresenter		# ~3 megs
koffice-filters
#kdeartwork			# only include some parts of kdeartwork
k3b
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

# make sure alsaunmute is there
alsa-utils

# make sure gnome-packagekit doesn't end up the KDE live images
-gnome-packagekit*

# remove input methods to free space
-scim*
-m17n*
-ibus*

# save some space (from @base)
-make
-nss_db
-autofs

%end

%post

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
DESKTOP="KDE"
DISPLAYMANAGER="KDE"
EOF

# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF

if [ -e /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png ] ; then
    # use image also for kdm
    mkdir -p /usr/share/apps/kdm/faces
    cp /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png /usr/share/apps/kdm/faces/fedora.face.icon
fi

# make liveuser use KDE
echo "startkde" > /home/liveuser/.xsession
chmod a+x /home/liveuser/.xsession
chown liveuser:liveuser /home/liveuser/.xsession

# set up autologin for user liveuser
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=liveuser/' /etc/kde/kdm/kdmrc

# set up user liveuser as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=liveuser/' /etc/kde/kdm/kdmrc

# add liveinst.desktop to favorites menu
mkdir -p /home/liveuser/.kde/share/config/
cat > /home/liveuser/.kde/share/config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/kde4/konqbrowser.desktop,/usr/share/applications/kde4/dolphin.desktop,/usr/share/applications/kde4/systemsettings.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# chmod +x ~/Desktop/liveinst.desktop to disable KDE's security warning
chmod +x /usr/share/applications/liveinst.desktop

# copy over the icons for liveinst to hicolor
cp /usr/share/icons/gnome/16x16/apps/system-software-install.png /usr/share/icons/hicolor/16x16/apps/
cp /usr/share/icons/gnome/22x22/apps/system-software-install.png /usr/share/icons/hicolor/22x22/apps/
cp /usr/share/icons/gnome/24x24/apps/system-software-install.png /usr/share/icons/hicolor/24x24/apps/
cp /usr/share/icons/gnome/32x32/apps/system-software-install.png /usr/share/icons/hicolor/32x32/apps/
cp /usr/share/icons/gnome/scalable/apps/system-software-install.svg /usr/share/icons/hicolor/scalable/apps/
touch /usr/share/icons/hicolor/

# Disable the update notifications of kpackagekit
cat > /home/liveuser/.kde/share/config/KPackageKit << KPACKAGEKIT_EOF
[CheckUpdate]
autoUpdate=0
interval=0

[Notify]
notifyLongTasks=2
notifyUpdates=0
KPACKAGEKIT_EOF

# Disable nepomuk
cat > /home/liveuser/.kde/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

# don't use prelink on a running KDE live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink

# small hack to enable plasma-netbook workspace on boot
if strstr "\`cat /proc/cmdline\`" netbook ; then
   mv /usr/share/autostart/plasma-desktop.desktop /usr/share/autostart/plasma-netbook.desktop
   sed -i 's/desktop/netbook/g' /usr/share/autostart/plasma-netbook.desktop
fi

EOF

%end
