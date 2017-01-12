# Maintained by the Fedora Python SIG:
# http://fedoraproject.org/wiki/SIGs/Python
# mailto:python-devel@lists.fedoraproject.org

# List of packages for the Python Classroom Spin
# This list is only for the headless apps

%packages

# Editors
vim-minimal
emacs
nano

# Version control
git
openssh-clients

# Pythons
python3-devel
python3-tools
python2-devel
python2-tools
pypy3-devel

# Python utils
python2-virtualenv
python3-tox
python2-ipython-console
python3-ipython-console

# Jupyter notebook (not yet in Fedora)
# python3-notebook
# python2-ipykernel
# python3-ipykernel

# Remove Pythons possibly recommended by tox
-python26
-python33
-python34
-python35
-python36
-pypy

# Python documentation
python3-docs
python2-docs

# C and C++ stuff
make
gcc
gcc-c++
valgrind

# Non-python Utils
wget
curl
bash-completion
unzip
sed
grep
less
tar

# workaround for consequence of RHBZ #1324623: without this, with
# yum-based creation tools, compose fails due to conflict between
# libcrypt and libcrypt-nss. dnf does not seem to have the same
# issue, so this may be dropped when appliance-creator is ported
# to dnf.
libcrypt-nss
-libcrypt

%end
