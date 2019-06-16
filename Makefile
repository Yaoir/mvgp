# Makefile for mvgp command

# set BINDIR to where you want the mvgp and cpgp programs installed
BINDIR=/home/jay/.bin

# set MANDIR to where you want the manual page installed
MANDIR=/usr/share/man/man1

# Release date. For ronn, when making manual page
RELDATE=2019-06-15

# Manual Page

man: mvgp.1.ronn
	@ronn --roff --manual="User Commands" --organization="Jay Ts" --date="$(RELDATE)" mvgp.1.ronn >/dev/null 2>&1
	@gzip -f mvgp.1
	@mv mvgp.1.gz man1
	@man -l man1/mvgp.1.gz

showman:
	@man -l man1/mvgp.1.gz

install:
	@cp mvgp $(BINDIR)

install-man:
	@cp man1/mvgp.1.gz $(MANDIR)

clean:
	rm -f man1/mvgp.1.gz

backup back bak:
	@cp -a cpgp Makefile man1 mvgp mvgp.1.ronn README.md TODO .bak

