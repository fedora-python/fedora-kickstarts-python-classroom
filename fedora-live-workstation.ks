# Maintained by the Fedora Workstation WG:
# http://fedoraproject.org/wiki/Workstation
# mailto:desktop@lists.fedoraproject.org

%include fedora-live-base.ks
%include fedora-workstation-packages.ks

part / --size 6144 

%post

# This is a huge file and things work ok without it
rm -f /usr/share/icons/HighContrast/icon-theme.cache

# Copy initial metadata for PackageKit
PK_PREFIX=`mktemp -d`
mkdir -p $PK_PREFIX/etc/yum.repos.d
if [ -f /etc/yum.repos.d/fedora.repo ] ; then
  cp /etc/yum.repos.d/fedora.repo $PK_PREFIX/etc/yum.repos.d/
  sed -i -e 's|^metalink=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch|baseurl=https://kojipkgs.fedoraproject.org/mash/branched/$basearch/os/|' \
         $PK_PREFIX/etc/yum.repos.d/fedora.repo
fi
if [ -f /etc/yum.repos.d/fedora-updates.repo ] ; then
  cp /etc/yum.repos.d/fedora-updates.repo $PK_PREFIX/etc/yum.repos.d/
  sed -i -e 's|^metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch|baseurl=https://kojipkgs.fedoraproject.org/mash/updates/f$releasever-updates/$basearch/|' \
         $PK_PREFIX/etc/yum.repos.d/fedora-updates.repo
fi
if [ -f /etc/yum.repos.d/fedora-updates-testing.repo ] ; then
  cp /etc/yum.repos.d/fedora-updates-testing.repo $PK_PREFIX/etc/yum.repos.d/
  sed -i -e 's|^metalink=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-f$releasever&arch=$basearch|baseurl=https://kojipkgs.fedoraproject.org/mash/updates/f$releasever-updates-testing/$basearch/|' \
         $PK_PREFIX/etc/yum.repos.d/fedora-updates-testing.repo
fi
if [ -f /etc/yum.repos.d/fedora-rawhide.repo ] ; then
  cp /etc/yum.repos.d/fedora-rawhide.repo $PK_PREFIX/etc/yum.repos.d/
  sed -i -e 's|^metalink=https://mirrors.fedoraproject.org/metalink?repo=rawhide&arch=$basearch|baseurl=https://kojipkgs.fedoraproject.org/mash/rawhide/$basearch/os/|' \
         $PK_PREFIX/etc/yum.repos.d/fedora-rawhide.repo
fi
rpm --root=$PK_PREFIX --initdb
DESTDIR=$PK_PREFIX /usr/libexec/packagekit-direct refresh
if [ -d /var/cache/PackageKit ] ; then
  mv $PK_PREFIX/var/cache/PackageKit/* /var/cache/PackageKit/
fi
rm -rf $PK_PREFIX

cat >> /etc/rc.d/init.d/livesys << EOF


# disable updates plugin
cat >> /usr/share/glib-2.0/schemas/org.gnome.software.gschema.override << FOE
[org.gnome.software]
download-updates=false
FOE

# don't run gnome-initial-setup
mkdir ~liveuser/.config
touch ~liveuser/.config/gnome-initial-setup-done

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'rhythmbox.desktop', 'shotwell.desktop', 'org.gnome.Nautilus.desktop', 'anaconda.desktop']
FOE

  # Make the welcome screen show up
  if [ -f /usr/share/anaconda/gnome/fedora-welcome.desktop ]; then
    mkdir -p ~liveuser/.config/autostart
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop /usr/share/applications/
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop ~liveuser/.config/autostart/
  fi

  # Copy Anaconda branding in place
  if [ -d /usr/share/lorax/product/usr/share/anaconda ]; then
    cp -a /usr/share/lorax/product/* /
  fi
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
