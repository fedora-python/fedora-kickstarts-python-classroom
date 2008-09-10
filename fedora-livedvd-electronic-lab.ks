# Description : Live DVD image for Fedora Electronic Lab
# last updated: 10 August 2008
#
# Maintainer(s):
# - Chitlesh Goorah <chitlesh a fedoraproject.org>
# - Thibault North  <tnorth a fedoraproject.org>

%include fedora-livecd-kde.ks

%packages

# KDE basic packages
kmenu-gnome
kdesvn
yakuake
kdebluetooth


# removing useless application from KDE ks
-kdegames
-koffice-kword
-koffice-kspread
-koffice-kpresenter
-koffice-filters


# some projects based on ghdl and gtkwave needs
zlib-devel


# Office
vym
openoffice.org-writer
openoffice.org-math
openoffice.org-writer2latex
openoffice.org-calc
openoffice.org-impress
openoffice.org-extendedPDF
openoffice.org-ooolatex
kile
planner


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
bluez-gnome
gnome-bluetooth


# ignore comps.xml and make sure these packages are included
rhgb
make
# include default fedora wallpaper
desktop-backgrounds-basic
fedora-logos
wget
tkcvs


# vlsi
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

# Hardware Description Languages
gtkwave
iverilog
drawtiming
ghdl
freehdl

# spice
ngspice
gnucap
gspiceui
gwave

# PCB and schematics
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

# Micro Programming
piklab
ktechlab
pikloops
sdcc

# Serial Port Terminals
gtkterm
picocom
minicom

# embedded
arm-gp2x-linux*
avr-*
avrdude
dfu-programmer
avarice
uisp

# computing
octave
octave-forge

# Oracle Berkeley database
db4-cxx
db4-tcl

# Extra support for compiling SystemC (not yet fedora compatible)
compat-gcc-34-c++

%end

%post

###### Fedora Electronic Lab ####################################################

# Fedora Electronic Lab:

mkdir -p /home/fedora/.kde/share/config/

# kill stupid klipper
cat > /home/fedora/.kde/share/config/klipperrc <<EOF
[General]
AutoStart=false
EOF

cat > /home/fedora/.kde/share/config/kxkbrc <<EOF
[Layout]
DisplayNames=us,ch,de,fr
IndicatorOnly=false
LayoutList=us,ch,de,fr
Model=pc104
Options=
ResetOldOptions=true
ShowFlag=true
ShowSingle=true
SwitchMode=Global
Use=true
EOF

# Chitlesh doesn't like the KDE icon on the kicker, but fedora's
# icon taken from fedora-logos and applied by kde-settings

# FEL doesn't need these and boots slowly
/sbin/chkconfig sendmail  off 2>/dev/null
/sbin/chkconfig nfs       off 2>/dev/null
/sbin/chkconfig nfslock   off 2>/dev/null
/sbin/chkconfig rpcidmapd off 2>/dev/null
/sbin/chkconfig rpcbind   off 2>/dev/null


%end
