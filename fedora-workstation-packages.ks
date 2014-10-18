%packages

# Exclude unwanted groups that fedora-live-base.ks pulls in
-@dial-up
-@input-methods
-@standard

# Actual package selection is done in workstation-product-environment in comps
@^workstation-product-environment

# Exclude unwanted packages from @anaconda-tools group
-gfs2-utils
-reiserfs-utils

%end
