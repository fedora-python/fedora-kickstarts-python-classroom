# Filename:
#   fedora-livecd-sugar.ks
# Maintainers:
#   Sebastian Dziallas <sdz AT fedoraproject DOT org>
#   Marco Pesenti Gritti <marcopg AT sugarlabs DOT org>

%include fedora-live-base.ks

%packages

# sugar!
@sugar-desktop

# e-mail client
alpine

# display manager
slim

# exclude input methods
-scim*
-m17n*

# avoid weird case where we pull in more festival stuff than we need
festival
festvox-slt-arctic-hts

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-wqy-bitmap-fonts
-dejavu-fonts-experimental
-words

%end

%post
cat > /etc/sysconfig/desktop <<EOF
DISPLAYMANAGER=/usr/bin/slim-dynwm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

chkconfig --level 5 setroubleshoot off 2>/dev/null
chkconfig --level 5 sendmail off 2>/dev/null
chkconfig --level 5 bluetooth off 2>/dev/null
chkconfig --level 5 cupsd off 2>/dev/null

# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null

# set up timed auto-login for after 60 seconds
cat >> /etc/slim.conf << FOE
auto_login	yes
default_user	liveuser
FOE

# setup xinitrc
echo "sugar-shell" > /home/liveuser/.xinitrc
chmod a+x /home/liveuser/.xinitrc
chown liveuser:liveuser /home/liveuser/.xinitrc

EOF

%end
