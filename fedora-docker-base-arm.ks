%include fedora-docker-base.ks

bootloader --timeout=1 --append="no_timer_check console=tty1 console=ttyS0,115200n8"

part /boot --fstype="ext4" --size=500
part /boot/efi --fstype="vfat" --size=100
