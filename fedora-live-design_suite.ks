# fedora-design-suite.ks
# Based on Live Workstation
# Description:
# - A Spin targeted towards professional designers
# Website: http://fedoraproject.org/wiki/Design_Suite
# Maintainers:
# - Luya Tshimbalanga <luya AT fedoraproject DOT org>
# - Previous maintainer Sebastian Dziallas

%include fedora-live-workstation.ks

# Size partition
part / --size 14336

%packages
# Switch to groups for design suite
@design-suite

# Preview Gnome Photos
gnome-photos

# Add gthumb for renaming group files
gthumb

# Extra wallpapers
f23-backgrounds-extras-base
f23-backgrounds-extras-gnome
f24-backgrounds-extras-base
f24-backgrounds-extras-gnome

# removal of unneeded applications
-gnome-boxes
-eog
-rdesktop

%end

%post
#Override the favorite desktop application in Dash
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'gnome-photos.desktop', 'gimp.desktop', 'inkscape.desktop', 'blender.desktop', 'libreoffice-writer.desktop', 'scribus.desktop', 'nautilus.desktop', 'bijiben.desktop', 'anaconda.desktop', 'list-design-tutorials.desktop']
FOE

# Add link to lists of tutorials
cat >> /usr/share/applications/list-design-tutorials.desktop << FOE
[Desktop Entry]
Name=List of design tutorials
GenericName=List of Tutorials for Designers
Comment=Reference of Design Related Tutorials
Exec=xdg-open https://fedoraproject.org/wiki/Design_Suite/Tutorials
Type=Application
Icon=applications-graphics
Categories=Graphics;Documentation;
FOE
chmod a+x /usr/share/applications/list-design-tutorials.desktop

# Add information about Fedora Design Suite
cat >> /usr/share/applications/fedora-design-suite.desktop << FOE
[Desktop Entry]
Name=Design Suite Info
GenericName=About Design Suite
Comment=Wiki page of Design Suite
Exec=xdg-open https://fedoraproject.org/wiki/Design_Suite
Type=Application
Icon=applications-internet
Categories=Documentation;
FOE
chmod a+x /usr/share/applications/fedora-design-suite.desktop

# Add information about Fedora Design Team
cat >> /usr/share/applications/fedora-design-team.desktop << FOE
[Desktop Entry]
Name=Design Team Info
GenericName=About Design Team 
Comment=Wiki page of Design Team
Exec=xdg-open https://fedoraproject.org/wiki/Design
Type=Application
Icon=applications-internet
Categories=Documentation;
FOE
chmod a+x /usr/share/applications/fedora-design-team.desktop

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

%end
