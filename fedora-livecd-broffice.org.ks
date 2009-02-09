# fedora-livecd-broffice.ks
#
# Description:
# - Provides the legal brand BrOffice.org for OpenOffice.org in Brazil
#
# Maintainer:
# - Igor Pires Soares <igor at fedoraproject.org>


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
broffice.org-calc
broffice.org-impress
broffice.org-draw


# We won't use these Asian fonts anyway
-lklug-fonts
-abyssinica-fonts
-andika-fonts
-bitstream-vera-*
-jomolhari-fonts
-lohit-fonts-*
-thaifonts-scalable
-kacst-fonts
-paktype-fonts
-baekmuk-*
-cjkunifonts-*
-VLGothic-fonts-*
-padauk-fonts
-khmeros-fonts-base
-un-*
-smc-fonts-meera
-samyak-fonts-*
-sarai-fonts
-stix-fonts
-cjkuni-*
-doulos-fonts
-hanazono-fonts
-urw-fonts
-thai-*

# remove input methods
-@input-methods
-m17n*
-scim*
-iok
-anthy
-kasumi
-libchewing
-ibus-*

# Saving space in order to get BrOffice.org in
-@games
-gnome-games-*
-gnome-utils
-gnome-doc-utils-stylesheets
-gnome-phone-manager
-gnome-speech
-planner
-dasher
-system-config-language
-evince-dvi
-evince-djvu
-ekiga
-tomboy
-f-spot
-cheese
-sound-juicer
-gok
-festival-*
-festvox-slt-arctic-hts

%end

