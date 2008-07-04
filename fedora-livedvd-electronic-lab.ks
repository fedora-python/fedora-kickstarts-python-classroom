# Description : Live DVD image for Fedora Electronic Lab
# last updated: 11 June 2008
#
# Maintainer(s):
# - Chitlesh Goorah <chitlesh a fedoraproject.org>
# - Thibault North <tnorth a fedoraproject.org>

%include fedora-livecd-kde.ks

%packages

# KDE basic packages
kmenu-gnome
kdesvn
yakuake


# include default fedora wallpaper
desktop-backgrounds-basic

wget
planner

# some projects based on ghdl and gtkwave needs
zlib-devel

#project management
vym
koffice-kspread
koffice-kword
koffice-kplato
koffice-filters

# some other extra packages
ntfsprogs
ntfs-3g
synaptics
setroubleshoot
smolt
smolt-firstboot
syslinux
gnupg
hal-cups-utils
firefox
libflashsupport
kile


# ignore comps.xml and make sure these packages are included
rhgb
make

#vlsi
alliance-doc
irsim
gds2pov
magic-doc
toped
xcircuit
qucs
netgen
pharosc
pharosc-alliance-devel
pharosc-doc
pharosc-magic-devel
pharosc-synopsys
pharosc-xcircuit
sk2py


#Hardware Description Languages
gtkwave
iverilog
drawtiming
ghdl
freehdl

#spice
ngspice
gnucap
#gspiceui
gwave

#PCB and schematics
geda-gschem
geda-examples
geda-gsymcheck
geda-gattrib
geda-utils
geda-docs
geda-gnetlist
gerbv
gresistor
kicad
pcb

#Micro Programming
piklab
ktechlab
pikloops
sdcc

# Serial Port Terminals
gtkterm
picocom
minicom

#embedded
arm-gp2x-linux*
avr-*
avrdude
dfu-programmer
avarice
uisp

#computing
octave
octave-forge

%end

%post

###### Fedora Electronic Lab ####################################################

# Fedora Electronic Lab: Kwin buttons
cat > /usr/share/kde-settings/kde-profile/default/share/config/kwinrc <<EOF
[Style]
ButtonsOnLeft=MB
ButtonsOnRight=FIAX
CustomButtonPositions=true
EOF


# kill stupid klipper
cat > /usr/share/kde-settings/kde-profile/default/share/config/klipperrc <<EOF
[General]
AutoStart=false
EOF

# use the LCD_Style clock as alliance's windows demand a lot of space on kicker
cat > /usr/share/kde-settings/kde-profile/default/share/config/clock_panelappletrc <<EOF
[Digital]
LCD_Style=false
Show_Date=false
Show_Seconds=true

[General]
Type=Digital
EOF


cat > /usr/share/kde-settings/kde-profile/default/share/config/kxkbrc <<EOF
[Layout]
DisplayNames=
EnableXkbOptions=false
IncludeGroups=
LayoutList=us,de,ch,fr,jp
Model=pc104
Options=
ResetOldOptions=false
ShowFlag=true
ShowSingle=true
StickySwitching=false
StickySwitchingDepth=2
SwitchMode=Global
Use=true
EOF

# Chitlesh doesn't like the KDE icon on the kicker, but fedora's
# This is a feature for Fedora and not for KDE
cp -fp /usr/share/icons/Bluecurve/16x16/apps/gnome-main-menu.png /usr/share/icons/crystalsvg/16x16/apps/kmenu.png
cp -fp /usr/share/icons/Bluecurve/24x24/apps/gnome-main-menu.png /usr/share/icons/crystalsvg/22x22/apps/kmenu.png
cp -fp /usr/share/icons/Bluecurve/32x32/apps/gnome-main-menu.png /usr/share/icons/crystalsvg/32x32/apps/kmenu.png
cp -fp /usr/share/icons/Bluecurve/48x48/apps/gnome-main-menu.png /usr/share/icons/crystalsvg/48x48/apps/kmenu.png


# FEL doesn't need these and boots slowly
/sbin/chkconfig anacron   off 2>/dev/null
/sbin/chkconfig sendmail  off 2>/dev/null
/sbin/chkconfig nfs       off 2>/dev/null
/sbin/chkconfig nfslock   off 2>/dev/null
/sbin/chkconfig rpcidmapd off 2>/dev/null
/sbin/chkconfig rpcbind   off 2>/dev/null


%end
