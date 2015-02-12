# This is a minimal Fedora install designed to serve as a Docker base image. 
#
# To keep this image minimal it only installs English language. You need to change
# yum configuration in order to enable other languages.

cmdline
bootloader --location=none
timezone --isUtc --nontp Etc/UTC
rootpw --plaintext qweqwe

keyboard us
firewall --disable
zerombr
clearpart --all
part / --size 3000 --fstype ext4
network --bootproto=dhcp --device=link --activate --onboot=on
reboot

%packages --excludedocs --instLangs=en --nocore
bash
fedora-release
rootfiles
vim-minimal
yum
#fakesystemd #TODO: waiting for review https://bugzilla.redhat.com/show_bug.cgi?id=1118740
-kernel


%end

%post --log=/tmp/anaconda-post.log
# Set the language rpm nodocs transaction flag persistently in the
# image yum.conf and rpm macros

LANG="en_US"
echo "%_install_lang $LANG" > /etc/rpm/macros.image-language-conf

awk '(NF==0&&!done){print "override_install_langs='$LANG'\ntsflags=nodocs";done=1}{print}' \
    < /etc/yum.conf > /etc/yum.conf.new
mv /etc/yum.conf.new /etc/yum.conf

echo "Import RPM GPG key"
releasever=$(rpm -q --qf '%{version}\n' fedora-release)
basearch=$(uname -i)
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$releasever-$basearch

rm -f /usr/lib/locale/locale-archive

#Setup locale properly
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8

rm -rf /var/cache/yum/*
rm -f /tmp/ks-script*

#Make it easier for systemd to run in Docker container
cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/
sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service

#Mask mount units and getty service so that we don't get login prompt
systemctl mask systemd-remount-fs.service dev-hugepages.mount sys-fs-fuse-connections.mount systemd-logind.service getty.target console-getty.service

rm -f /etc/machine-id
rm -f /etc/fstab

%end
