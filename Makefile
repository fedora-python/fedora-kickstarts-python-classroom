# Get the version name first by seeing if HEAD is tagged
version := $(shell git tag --points-at HEAD)
# And if it wasn't use a git hash
ifeq ($(version),)
  version := $(shell git log -1 --abbrev=8 --pretty=git%h)
endif

all: dist

clean:
	rm -f spin-kickstarts-*.tar.gz

dist:
	git archive --format=tar --prefix=spin-kickstarts-$(version)/ HEAD | gzip > spin-kickstarts-$(version).tar.gz

publish:
	scp spin-kickstarts-$(version).tar.gz fedorahosted.org:spin-kickstarts

dist-clean:
	git clean -f -d
