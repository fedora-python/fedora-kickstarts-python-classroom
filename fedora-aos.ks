# Kickstart file to build the appliance operating
# system for fedora.
# This is based on the work at http://www.thincrust.net
lang C
keyboard us
timezone US/Eastern
auth --useshadow --enablemd5
selinux --permissive
firewall --disabled
bootloader --timeout=1 --append="acpi=force"
network --bootproto=dhcp --device=eth0 --onboot=on
services --enabled=network

# Uncomment the next line
# to make the root password be thincrust
# By default the root password is emptied
#rootpw --iscrypted $1$uw6MV$m6VtUWPed4SqgoW6fKfTZ/

#
# Partition Information. Change this as necessary
# This information is used by appliance-tools but
# not by the livecd tools.
#
part / --size 550 --fstype ext3 --ondisk sda

#
# Repositories
#
# To compose against the current release tree, use the following "repo" (enabled by default)
#repo --name=released --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-10&arch=$basearch
# To include updates, use the following "repo" (enabled by default)
#repo --name=updates --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f10&arch=$basearch

# To compose against rawhide, use the following "repo" (disabled by default)
repo --name=rawhide --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide&arch=$basearch

# To compose against local trees, (edit and) use:
#repo --name=f10 --baseurl=http://localrepo/fedora/releases/10/Everything/$basearch/os/
#repo --name=f10-updates --baseurl=http://localrepo/fedora/updates/10/$basearch/

#
# Add all the packages after the base packages
#
%packages --excludedocs --nobase
bash
kernel
grub
e2fsprogs
passwd
policycoreutils
chkconfig
rootfiles
yum
vim-minimal
acpid
#needed to disable selinux
lokkit

#Allow for dhcp access
dhclient
iputils

#
# Packages to Remove
#

# no need for kudzu if the hardware doesn't change
-kudzu
-prelink
-setserial
-ed

# Remove the authconfig pieces
-authconfig
-rhpl
-wireless-tools

# Remove the kbd bits
-kbd
-usermode

# these are all kind of overkill but get pulled in by mkinitrd ordering
-mkinitrd
-kpartx
-dmraid
-mdadm
-lvm2
-tar

# selinux toolchain of policycoreutils, libsemanage, ustr
-policycoreutils
-checkpolicy
-selinux-policy*
-libselinux-python
-libselinux

# Things it would be nice to loose
-fedora-logos
generic-logos
-fedora-release-notes
%end

#
# Add custom post scripts after the base post.
#
%post

%end

