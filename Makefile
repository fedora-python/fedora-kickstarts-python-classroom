all: dist

clean:
	rm -f spin-kickstarts-*.tar.gz

dist:
	git archive --format=tar --prefix=spin-kickstarts-`git tag --points-at HEAD`/ HEAD | gzip > spin-kickstarts.tar-`git tag --points-at HEAD`.gz

dist-clean:
	git clean -f -d
