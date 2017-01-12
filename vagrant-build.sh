#!/usr/bin/bash -eux

# Usage:
# ./vagrant-build.sh fedora-live-python-classroom.ks try-3 --release 26

ks="$1"
shift
dir="$1"
shift

# Put the flat ks file to vagrant
ksflatten -v, --config "$ks" -o "vagrant/$ks" --version F25

pushd vagrant
vagrant up

# Run livemedia-creator in that box
(vagrant ssh || :) << EOF
set -o xtrace
sudo setenforce 0
sudo livemedia-creator --make-iso --no-virt --ks "/vagrant/$ks" --resultdir="results/$dir" --logfile="results/logs/$dir/$dir.log" $@ || sudo rm "results/$dir/*.img"
EOF

# Get the results
vagrant scp ":results/$dir" ../results
vagrant scp ":results/logs/$dir" ../results/logs

# Delete the results from the box
(vagrant ssh || :) << EOF
set -o xtrace
sudo rm -r "results/$dir" "results/logs/$dir"
EOF

vagrant halt
popd
