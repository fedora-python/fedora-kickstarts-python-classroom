# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include fedora-live-base.ks

part / --size 4096 

%packages
-realmd                     # only seems to be used in GNOME
-PackageKit*                # we switched to yumex, so we don't need this
firefox
lightdm
lightdm-gtk
initial-setup
setroubleshoot
mate-desktop
libmatekeyring
mate-keyring
libmatekbd
libmatewnck
libmateweather
mate-icon-theme
mate-dialogs
mate-file-manager
mate-polkit
mate-window-manager
mate-settings-daemon
mate-menus
mate-terminal
mate-panel
mate-backgrounds
mate-themes
mate-notification-daemon
mate-image-viewer
mate-control-center
mate-screensaver
mate-file-manager
mate-file-manager-image-converter
mate-file-manager-sendto
mate-file-manager-open-terminal
mate-text-editor
mate-media
mate-power-manager
mate-system-monitor
mate-applets
mate-bluetooth
mate-utils
compiz
compiz-plugins-main
compiz-plugins-extra
compiz-manager
compizconfig-python
compiz-plugins-unsupported
compiz-bcop
compiz-mate
libcompizconfig
compiz-plugins-main
ccsm
emerald-themes
emerald
fusion-icon
fusion-icon-gtk
@libreoffice
NetworkManager
NetworkManager-l2tp
NetworkManager-openconnect
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-vpnc
brasero
dconf
dconf-editor
desktop-backgrounds-basic
fedora-icon-theme
firewall-config
geany
gvfs
gvfs-smb
gvfs-fuse
gvfs-afc
gvfs-mtp
gtk2-engines
hexchat
imsettings-mate
pavucontrol
simple-scan
claws-mail
tigervnc
transmission-gtk
vim-enhanced
yelp
yumex

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @standard
-smartmontools

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF


# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
fi
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop


# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# set MATE as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=mate/' /etc/lightdm/lightdm.conf

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/
EOF

%end
