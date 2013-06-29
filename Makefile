# Get the version name first by seeing if HEAD is tagged
version := $(shell git tag --points-at HEAD)
# And if it wasn't use a git hash
ifeq ($(version),)
  version := $(shell git log -1 --abbrev=8 --pretty=git%h)
endif

DESTDIR := /usr

DATADIR := $(DESTDIR)/share

DOCDIR := $(DATADIR)/doc/

name := spin-kickstarts

all: dist

install:
	install *.ks custom l10n $(DATADIR)/$(name)
	install AUTHORS COPYING README $(DOCDIR)/$(name)

clean:
	rm -f $(name)-*.tar.gz

dist:
	git archive --format=tar --prefix=$(name)-$(version)/ HEAD | gzip > $(name)-$(version).tar.gz

publish:
	scp $(name)-$(version).tar.gz fedorahosted.org:$(name)

dist-clean:
	git clean -f -d
