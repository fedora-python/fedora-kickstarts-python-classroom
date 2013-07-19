# fedora-design-suite.ks
# Based on Live Desktop
# Description:
# - A Spin targeted towards professional designers
# Website: http://fedoraproject.org/wiki/Design_Suite
# Maintainers:
# - Luya Tshimbalanga <luya AT fedoraproject DOT org>
# - Previous maintainer Sebastian Dziallas

%include fedora-live-desktop.ks

#DVD size partition
part / --size 8192

%packages

# graphics
blender
bluefish 
#cinepaint will be orphaned soon
cmyktool
darktable
dia
entangle
fontforge
font-manager 
gimp
gimp-*-plugin
gpick
GREYCstoration-gimp 
hugin 
inkscape
mypaint
nautilus-image-converter
optipng
pencil
scribus
colord-extra-profiles 
synfigstudio
# ufraw # dropped as duplicate of darktable
xournal

# office
pdfshuffler  

# internet
filezilla

# audio & video
audacity
pitivi

# fonts
aajohan-comfortaa-fonts
adobe-source-sans-pro-fonts
lato-fonts
overpass-fonts

# removal of duplicated and unneeded applications
-gnome-boxes
-eog

# Legacy cmdline things we don't want
-krb5-auth-dialog
-krb5-workstation
-pam_krb5
-quota
-minicom
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-telnet
-nfs-utils
-ypbind
-yp-tools
-rpcbind
-acpid
-ntsysv

%end

%post

# Set favourite apps for Design Suite
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'gimp.desktop', 'shotwell.desktop', 'inkscape.desktop', 'scribus.desktop', 'blender.desktop', 'nautilus.desktop', 'anaconda.desktop']
FOE


# Add link to the Inkscape Course
cat >> /usr/share/applications/inkscape-course.desktop << FOE
[Desktop Entry]
Name=Introduction To Inkscape
GenericName=Inkscape Course
Comment=Materials from Máirín Duffy's Inkscape Class
Exec=xdg-open http://linuxgrrl.com/learn/Introduction_To_Inkscape
Type=Application
Icon=fedora-logo-icon
Categories=Graphics;Documentation;
FOE
chmod a+x /usr/share/applications/inkscape-course.desktop

EOF

%end
