%packages
@firefox
@gnome-desktop
@libreoffice

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @standard
-smartmontools

# We use gnome-control-center's printer and input sources panels instead
-system-config-printer
-im-chooser

# There's been some debate about removing sendmail from @standard, but it's
# being punted for now.  At least we can fix it in the desktop spin.
# https://lists.fedoraproject.org/pipermail/devel/2013-July/186796.html
-sendmail
%end
