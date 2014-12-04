%packages

# Exclude unwanted groups that fedora-live-base.ks pulls in
-@dial-up
-@fedora-release-nonproduct
-@input-methods
-@standard

# Most of the heavy work is done in comps
@^workstation-product-environment
@libreoffice

# Exclude unwanted packages from @anaconda-tools group
-gfs2-utils
-reiserfs-utils

%end
