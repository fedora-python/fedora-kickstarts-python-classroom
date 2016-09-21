%packages
@base-x
@fonts
@input-methods
@multimedia
@printing
%end

%post
# Most of the ARM X accelerated drivers need some level of CMA allocation
sed -i 's/\(append .*\)/\1 cma=192MB/' /boot/extlinux/extlinux.conf

%end
