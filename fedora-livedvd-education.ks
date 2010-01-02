# fedora-livedvd-education.ks
#
# Description:
# - Fedora Live Spin with the purpose to create a ready-to-go 
#   development environment for contributing to educational
#   projects inside, but also outside of the Fedora ecosystem.
#
# Maintainers:
# - Sebastian Dziallas <sdz AT fedoraproject DOT org>
# - Fedora Education SIG

%include fedora-live-base.ks

# we need more space now
part / --size=8192

%packages

# desktop environments
@gnome-desktop
@sugar-desktop
sugar-emulator

# education
avogadro
gnuplot
kdeedu
moodle
octave

# internet
# education-bookmarks
firefox
java-1.6.0-openjdk-plugin
xchat-gnome

# office
evince
openoffice.org-base
openoffice.org-calc
openoffice.org-impress
openoffice.org-math
openoffice.org-writer

# graphics
gimp
inkscape

# audio & video
totem
totem-mozplugin

# stuff to make sugar-jhbuild work out of the box
at-spi-python
avahi-gobject-devel
avahi-tools
csound-devel
enchant-devel
fribidi-devel
icon-naming-utils
icon-slicer
libcroco-devel
libffi-devel
libgsf-devel
librsvg2-devel
loudmouth-devel
poppler-glib-devel
python-distutils-extra
redhat-lsb
wv-devel

# development
@development-libs
@development-tools
@fedora-packager
@gnome-software-development
diveintopython
giggle
numpy
pygame
python-gasp
python-sphinx
scipy

# eclipse environment
@eclipse
eclipse-eclox
eclipse-texlipse

# additional removals from gnome
-evolution
-gok
-gthumb
-nautilus-sendto
-orca
-tomboy

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-words

# exclude input methods
-scim*
-m17n*

# save some space
-gnome-user-docs
-nss_db
-vino
-isdn4k-utils
-dasher
# not needed for gnome
-acpid

%end

%post

cat >> /etc/rc.d/init.d/livesys << EOF

# enable the logout menu item in Sugar
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/sugar/show_logout true >/dev/null

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=60
FOE

# create file for xchat default servers
mkdir -p /home/liveuser/.xchat-gnome

cat >> /home/liveuser/.xchat-gnome/servlist_.conf << FOE
v=0.26.0

N=FreeNode
J=#fedora-edu,#sugar,#teachingopensource
F=3
D=0
S=irc.freenode.net
FOE

chown liveuser:liveuser /home/liveuser/.xchat-gnome/servlist_.conf

EOF

%end
