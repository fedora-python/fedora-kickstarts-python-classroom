# Common packages removed from comps
# For F14, these removals should be moved to comps itself

%packages

# save some space
-specspo
-esc
-samba-client
-a2ps
-mpage
-redhat-lsb
-sox
-hplip
-hpijs
#ssmtp
-numactl
-isdn4k-utils
-autofs
# smartcards won't really work on the livecd.
-coolkey
-ccid
# duplicate functionality
-pinfo
-vorbis-tools
-wget
# lose the compat stuff
-compat*

# qlogic firmwares
-ql2100-firmware
-ql2200-firmware
-ql23xx-firmware
-ql2400-firmware

# scanning takes quite a bit of space :/
-xsane
-xsane-gimp
-sane-backends

%end
