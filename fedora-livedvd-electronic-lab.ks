# Description : Live DVD image for Fedora Electronic Lab
#
# Maintainer(s):
# - Chitlesh Goorah <chitlesh a fedoraproject.org>
# - Thibault North  <tnorth   a fedoraproject.org>

%include fedora-livecd-kde.ks

# DVD payload
part / --size=8192

%packages

@electronic-lab


# Embedded design
eclipse-cdt
eclipse-cdt-sdk
eclipse-egit
eclipse-epic
eclipse-rcp
eclipse-subclipse
doxygen
splint

# KDE basic packages
kdesvn
kdesdk
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
dia
vym
openoffice.org-writer
openoffice.org-math
openoffice.org-writer2latex
openoffice.org-calc
openoffice.org-impress
openoffice.org-extendedPDF
openoffice.org-ooolatex
kile
tetex-IEEEtran
planner
graphviz


# some other extra packages
firefox
make
wget
tkcvs


# debugging tools
gdb
valgrind
kdbg
wireshark-gnome
qemu


# EDA/CAD department
db4-cxx
db4-tcl
perl-Test-Pod
perl-Test-Pod-Coverage


# Extra support for compiling SystemC (not fedora compatible)
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
