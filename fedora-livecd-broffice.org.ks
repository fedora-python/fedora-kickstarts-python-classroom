# fedora-livecd-broffice.ks
#
# Description:
# - Provides the legal brand "BrOffice.org" for OpenOffice.org in Brazil
#
# Maintainer:
# - Igor Pires Soares <igor at fedoraproject.org>


%include fedora-livecd-desktop.ks

lang pt_BR.UTF-8
keyboard br-abnt2
timezone America/Sao_Paulo


%packages --instLangs en_US:es:pt_BR

# L10n packages
@brazilian-support
hunspell-pt

# To avoid double functionality we will drop abiword and gnumeric and include BrOffice.org
-abiword
-gnumeric
-planner
broffice.org-*

# Include some additional packages
@java
vino
gnome-games
brasero
bitstream-vera-*
gimp
inkscape

# We won't use these Asian fonts
-lklug-fonts
-abyssinica-fonts
-jomolhari-fonts
-lohit-*
-baekmuk-*
-vlgothic-fonts-*
-un-*
-samyak-fonts-*
-sarai-fonts
-stix-fonts
-cjkuni-*
-hanazono-fonts
-thai-*
-smc-meera-fonts
-ipa-pgothic-fonts
-kacst-*
-khmeros-base-fonts
-paktype-*

# remove unnecessary input methods
-@input-methods
-m17n*
-scim*
-iok
-anthy
-kasumi
-libchewing

# include only the input methods we really need
ibus
im-chooser
gtk2-immodules

%end

