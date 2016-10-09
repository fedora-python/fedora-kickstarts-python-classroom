repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
#repo --name=updates-testing --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-testing-f$releasever&arch=$basearch
url --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
