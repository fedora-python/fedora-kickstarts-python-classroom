bootloader --location=none
part /boot --size=512 --fstype ext3
part swap --size=512 --fstype swap
part / --grow --size=3000 --fstype ext4

