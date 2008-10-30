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
broffice.org-calc
broffice.org-impress
broffice.org-draw


# We won't use these Asian fonts anyway
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
-padauk-fonts
-khmeros-fonts-base
-un-core-fonts-*
-smc-fonts-meera

# exclude input methods
-m17n*
-scim*

# Saving space in order to get BrOffice.org in
-gnome-utils
-gnome-games-*
-gnome-doc-utils-stylesheets
-gnome-phone-manager
-gnome-speech
-planner
-dasher
-system-config-language
-evince-dvi
-evince-djvu
-ekiga
-f-spot
-cheese
-sound-juicer
-gok
-festival-*
-festvox-slt-arctic-hts

%end

