# fedora-livecd-broffice.ks
#
# Maintainer(s):
# - Igor Pires Soares <igor at projetofedora.org>


%include fedora-livecd-desktop.ks

lang pt_BR.UTF-8
keyboard br-abnt2
timezone America/Sao_Paulo

%packages
@brazilian-support
hunspell-pt


# To avoid double functionality we will drop abiword and gnumeric and put BrOffice.org in
-abiword
-gnumeric
-gimp-*
broffice.org-writer
broffice.org-math
broffice.org-impress
broffice.org-draw


# We won't use these Asiatic fonts anyway
-lklug-fonts
-abyssinica-fonts
-jomolhari-fonts
-lohit-fonts-*
-thaifonts-scalable
-kacst-fonts
-paktype-fonts
-baekmuk-*
-cjkunifonts-*
-VLGothic-fonts
-dejavu-fonts-experimental


# Saving space in order to get BrOffice.org in
-gnome-utils
-planner
-aspell-*
-codeina
-gnome-games-*
-scim-python*
-scim-chewing
-scim-pinyin
-dasher
-system-config-language
-evince-dvi
-evince-djvu
-ekiga
-f-spot


# Debranding the spin
-fedora-logos
generic-logos

%end

%post
# system-config-keyboard doesn't really work (missing xorg.conf etc)
cat >>/etc/X11/xorg.conf << EOF
Section "InputDevice"
    Identifier "Keyboard0"
    Driver "kbd"
    Option "XkbLayout" "br-abnt2"
EndSection
EOF

# Needed for spin debranding
sed -i -e 's/Fedora/Generic/g' /etc/fedora-release

%end
