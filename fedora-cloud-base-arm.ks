%include fedora-cloud-base.ks

bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyAMA0,115200n8"

part /boot --fstype="ext4" --size=500
part /boot/efi --fstype="vfat" --size=100

%packages
efibootmgr
grub2-efi
shim
%end
