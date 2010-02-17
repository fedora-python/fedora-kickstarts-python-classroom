%include fedora-live-base.ks

part / --size 6000

%packages
@gnome-desktop
firefox
xchat-gnome
@haskell
cpphs
ghc-*-devel
ghc-*-doc
hugs98*
@development-tools
@fedora-packager
devhelp
emacs
xmonad
%end
