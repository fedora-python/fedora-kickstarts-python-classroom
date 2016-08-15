lang en_US.UTF-8
#keyboard us
auth --useshadow --passalgo=sha512
selinux --enforcing
firewall --enabled --service=mdns,ssh

# configure extlinux bootloader
bootloader extlinux

part /boot --size=512 --fstype ext4
part swap --size=512 --fstype swap
part / --size=3584 --fstype ext4

# make sure that initial-setup runs and lets us do all the configuration bits
firstboot --reconfig

services --enabled=ssh,NetworkManager,avahi-daemon,rsyslog,chronyd,initial-setup --disabled=network

%include fedora-repo.ks

%packages
@core
@standard
@hardware-support
@dial-up

kernel
dracut-config-generic
# install tools needed to manage and boot arm systems
@arm-tools

chrony
extlinux-bootloader
initial-setup
initial-setup-gui
#lets resize / on first boot
# dracut-modules-growroot

# remove this in %post
dracut-config-generic


# make sure all the locales are available for inital0-setup and anaconda to work
glibc-all-langpacks

# workaround for consequence of RHBZ #1324623: without this, with
# yum-based creation tools, compose fails due to conflict between
# libcrypt and libcrypt-nss. dnf does not seem to have the same
# issue, so this may be dropped when appliance-creator is ported
# to dnf.
libcrypt-nss
-libcrypt
%end

%post

# work around for poor key import UI in PackageKit
rm -f /var/lib/rpm/__db*
releasever=$(rpm -q --qf '%{version}\n' fedora-release)
basearch=armhfp
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch
echo "Packages within this ARM disk image"
rpm -qa
# Note that running rpm recreates the rpm db files which aren't needed or wanted
rm -f /var/lib/rpm/__db*

# remove random seed, the newly installed instance should make it's own
rm -f /var/lib/systemd/random-seed

# Because memory is scarce resource in most arm systems we are differing from the Fedora
# default of having /tmp on tmpfs.
echo "Disabling tmpfs for /tmp."
systemctl mask tmp.mount

dnf -y remove dracut-config-generic

%end

