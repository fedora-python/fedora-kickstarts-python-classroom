clean:
	rm -f spin-kickstarts.tar.gz

dist:
	git archive --format=tar --prefix=spin-kickstarts HEAD | gzip > spin-kickstarts.tar.gz
