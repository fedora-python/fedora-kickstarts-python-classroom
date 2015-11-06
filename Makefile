# Get a version name based off the nearest tag (include lightweight tags)
version := $(shell git describe --tags)

DESTDIR := /usr

DATADIR := $(DESTDIR)/share

DOCDIR := $(DATADIR)/doc

name := spin-kickstarts

all: dist

install:
	mkdir -p -m 755 $(DATADIR)/$(name)
	install *.ks* -m 644 $(DATADIR)/$(name)
	mkdir -p -m 755 $(DATADIR)/$(name)/custom
	install -m 644 custom/* $(DATADIR)/$(name)/custom
	mkdir -p -m 755 $(DATADIR)/$(name)/l10n
	install -m 644 l10n/* $(DATADIR)/$(name)/l10n
	mkdir -p -m 755 $(DATADIR)/$(name)/snippets
	install -m 644 snippets/* $(DATADIR)/$(name)/snippets

clean:
	rm -f $(name)-*.tar.gz

dist:	$(name)-$(version).tar.gz

$(name)-$(version).tar.gz:
	git archive --format=tar --prefix=$(name)-$(version)/ HEAD | gzip > $(name)-$(version).tar.gz

publish:	$(name)-$(version).tar.gz
	scp $(name)-$(version).tar.gz fedorahosted.org:$(name)

dist-clean:
	git clean -f -d
