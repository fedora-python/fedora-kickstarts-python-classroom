%include ../fedora-livecd-desktop.ks

%packages
gdb
strace
ltrace
libdrm
pidgin
mc
vim
nano
wget
xorg-x11-apps
gtk-recordmydesktop
gconf-editor
gimp
nautilus-open-terminal
abiword
# save some space
-empathy
-gnome-games
-brasero*
-sound-juicer
-gthumb
-gnome-backgrounds
-desktop-backgrounds*
-evolution
-shotwell
-planner
-openoffice*
-java*
# brand as fedora test spin
fedora-logos
-generic-logos
# glib2 is needed to set up favorites, though it probably gets pulled in anyway.
glib2
%end

%post
# Set Test_Day:Current as default browser homepage
unzip /usr/lib/firefox-*/omni.jar chrome/en-US/locale/browser/browser.properties -d /tmp
cat << EOF > /tmp/chrome/en-US/locale/browser/browser.properties
browser.startup.homepage=https://fedoraproject.org/wiki/Test_Day:Current
EOF
(cd /tmp; zip /usr/lib/firefox-*/omni.jar chrome/en-US/locale/browser/browser.properties)
rm -f /tmp/chrome/en-US/locale/browser/browser.properties

# Create a .desktop link for Test Day wiki
mkdir -p /etc/skel/Desktop
cat << EOF > /etc/skel/Desktop/testday-wiki.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Participate in a Test Day
Type=Link
URL=https://fedoraproject.org/wiki/Test_Day:Current
Icon=gnome-fs-bookmark
EOF

# Create a .desktop link for Test Day IRC chat
cat << EOF > /etc/skel/Desktop/testday-irc.desktop
[Desktop Entry]
Encoding=UTF-8
Name=Connect to a Test Day chat
Type=Link
URL=http://webchat.freenode.net/?channels=fedora-test-day
Icon=gnome-fs-bookmark
EOF

# Add gnome-terminal shortcut to desktop
cp /usr/share/applications/gnome-terminal.desktop /etc/skel/Desktop

# Change the favorites using a vendor override. (Adding a profile would
# be another way to do this.)
cat << EOF > /usr/share/glib-2.0/schemas/qa-testday.gschema.override
[org/gnome/shell]
favorite-apps=['mozilla-firefox.desktop', 'nautilus.desktop', 'testday-wiki.desktop', 'testday-irc.desktop', 'gnome-terminal.desktop']
EOF
glib-compile-schemas
%end
