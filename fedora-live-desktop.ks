# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include fedora-live-base.ks

part / --size 4096

%packages
@graphical-internet
@sound-and-video
@gnome-desktop
@office

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @base
-smartmontools

# The gnome-shell team does not want extensions in the default spin;
# ibus support in gnome-shell will be integrated in GNOME 3.4
-ibus-gnome3

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=false
FOE

# and hide the lock screen option
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override << FOE
[org.gnome.desktop.lockdown]
disable-lock-screen=true
FOE

# disable updates plugin
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.updates.gschema.override << FOE
[org.gnome.settings-daemon.plugins.updates]
active=false
FOE

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'empathy.desktop', 'rhythmbox.desktop', 'shotwell.desktop', 'openoffice.org-writer.desktop', 'nautilus.desktop', 'anaconda.desktop']
FOE

  cat > /usr/bin/anaconda-notification << FOE
#!/usr/bin/env python

from gi.repository import GLib
from gi.repository import Gio
from gi.repository import Notify
import sys
import os
import time

def install_cb(n, action, data):
   assert action == "install"
   n.close()
   os.execlp("liveinst", "liveinst")

def closed_cb(user_data):
    sys.exit()

def get_anaconda_desktop_file():
    desktop_files = ['/usr/share/applications/anaconda.desktop',
                     '/usr/share/applications/liveinst.desktop']

    for f in desktop_files:
        if os.path.isfile(f):
            return f

    return ""

def show_notification(n):
    # Spin 10 seconds, waiting for the notification service to start
    retval = False
    for i in range(1, 10):
        try:
            retval = n.show()
            break
        except:
            time.sleep(1)

    return retval

if __name__ == '__main__':
    appinfo = Gio.DesktopAppInfo()
    try:
       desktop = appinfo.new_from_filename(get_anaconda_desktop_file())
    except:
       sys.exit(1)
    label = desktop.get_name()
    actionlabel = desktop.get_generic_name()

    if not Notify.init(label):
        sys.exit(1)

    n = Notify.Notification()
    n.set_property("summary",label)
    n.set_property("body",
        "You are currently using an uninstalled live image.\n" +
        "If you want to keep using Fedora, you can install " +
        "it to your hard disk.")
    n.set_property("icon-name","anaconda")
    n.set_urgency(Notify.Urgency.CRITICAL)

    n.connect("closed", closed_cb)
    n.add_action("install", actionlabel, install_cb, None, None)

    if not show_notification(n):
        print "Failed to send notification"
        sys.exit(1)

    GLib.MainLoop().run()
FOE
  chmod +x /usr/bin/anaconda-notification

  mkdir -p ~liveuser/.config/autostart
  cat > ~liveuser/.config/autostart/anaconda-notification.desktop << FOE
[Desktop Entry]
Name=Fedora Install Notification
Exec=anaconda-notification
Type=Application
X-GNOME-Autostart-enabled=true
FOE

  chown -R liveuser:liveuser /home/liveuser/.config/
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

EOF

%end
