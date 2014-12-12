NAME=scl-utils
VERSION=`date +%Y%m%d`
WARNINGS?=-Wall -Wshadow -Wcast-align -Winline -Wextra -Wmissing-noreturn
CFLAGS?=-O2
CFILES=scl.c
OTHERFILES=Makefile LICENSE scl_enabled scl_source macros.scl scl.1 scldeps.sh scl.attr sclbuild.attr brp-scl-compress brp-scl-python-bytecompile scl.bash
SOURCES=$(CFILES) $(OTHERFILES)

BINDIR?=/usr/bin
MANDIR?=/usr/share/man
RPMCONFDIR?=/usr/lib/rpm
CNFDIR?=/etc

all: scl

scl: $(SOURCES) $(OTHERFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) $(WARNINGS) $(CFILES) -o $@

clean:
	rm -f *.o scl

distclean: clean
	rm -f *~

dist: all
	LANG=C
	rm -rf $(NAME)-$(VERSION)
	mkdir $(NAME)-$(VERSION)
	cp $(SOURCES) $(NAME)-$(VERSION)
	tar fcz $(NAME)-$(VERSION).tar.gz $(NAME)-$(VERSION)
	rm -rf $(NAME)-$(VERSION)

install: all
	mkdir -p $(DESTDIR)/$(BINDIR)
	mkdir -p $(DESTDIR)/$(CNFDIR)/rpm
	mkdir -p $(DESTDIR)/$(CNFDIR)/bash_completion.d
	mkdir -p $(DESTDIR)/$(RPMCONFDIR)/fileattrs
	cp macros.scl $(DESTDIR)/$(CNFDIR)/rpm
	cp scl $(DESTDIR)/$(BINDIR)
	cp scl_enabled $(DESTDIR)/$(BINDIR)
	cp scl_source $(DESTDIR)/$(BINDIR)
	cp scl.1 $(DESTDIR)/$(MANDIR)/man1
	cp scl.attr $(DESTDIR)/$(RPMCONFDIR)/fileattrs
	cp sclbuild.attr $(DESTDIR)/$(RPMCONFDIR)/fileattrs
	cp scldeps.sh $(DESTDIR)/$(RPMCONFDIR)
	cp brp-scl-compress $(DESTDIR)/$(RPMCONFDIR)
	cp brp-scl-python-bytecompile $(DESTDIR)/$(RPMCONFDIR)
	cp scl.bash $(DESTDIR)/$(CNFDIR)/bash_completion.d

uninstall:
	rm -f $(BINDIR)/scl $(BINDIR)/scl_enabled $(BINDIR)/scl_source
	rm -f $(CNFDIR)/rpm/macros.scl
	rm -f $(MANDIR)/man1/scl.1
	rm -f $(RPMCONFDIR)/fileattrs/scl.attr
	rm -f $(RPMCONFDIR)/fileattrs/sclbuild.attr
	rm -f $(RPMCONFDIR)/scldeps.sh
	rm -f $(RPMCONFDIR)/brp-scl-compress
	rm -f $(RPMCONFDIR)/brp-scl-python-bytecompile
	rm -f $(CNFDIR)/bash_completion.d/scl.bash