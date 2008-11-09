# Description : Live DVD image for Fedora Electronic Lab
# last updated: 09 November 2008 - ready for F10 Cambridge.
#
# Maintainer(s):
# - Chitlesh Goorah <chitlesh a fedoraproject.org>
# - Thibault North  <tnorth a fedoraproject.org>

%include fedora-livecd-kde.ks

# DVD payload
part / --size=8192

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
-kdeedu-kstars

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
# debugging tools
gdb
valgrind
kdbg
wireshark-gnome
qemu

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

cat >> /etc/rc.d/init.d/livesys << EOF

# kill stupid klipper
cat > /home/liveuser/.kde/share/config/klipperrc <<KLIPPER_EOF
[General]
AutoStart=false
KLIPPER_EOF

chown liveuser:liveuser /home/liveuser/.kde/share/config/klipperrc

cat > /home/liveuser/.kde/share/config/kxkbrc << KXKBRC_EOF
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
KXKBRC_EOF

chown liveuser:liveuser /home/liveuser/.kde/share/config/kxkbrc

# Chitlesh doesn't like the KDE icon on the kicker, but fedora's
# icon taken from fedora-logos and applied by kde-settings

# FEL doesn't need these and boots slowly
/sbin/chkconfig sendmail  off 2>/dev/null
/sbin/chkconfig nfs       off 2>/dev/null
/sbin/chkconfig nfslock   off 2>/dev/null
/sbin/chkconfig rpcidmapd off 2>/dev/null
/sbin/chkconfig rpcbind   off 2>/dev/null

EOF

%end
