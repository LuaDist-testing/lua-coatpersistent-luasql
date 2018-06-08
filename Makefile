
LUA     := lua
VERSION := $(shell cd src && $(LUA) -e "m = require [[Coat.Persistent]]; print(m._VERSION)")
TARBALL := lua-coatpersistent-$(VERSION).tar.gz
REV     := 1

LUAVER  := 5.3
PREFIX  := /usr/local
DPREFIX := $(DESTDIR)$(PREFIX)
LIBDIR  := $(DPREFIX)/share/lua/$(LUAVER)
INSTALL := install

all:
	@echo "Nothing to build here, you can just make install"

install: install.luasql

install.luasql:
	$(INSTALL) -m 644 -D src/Coat/Persistent.lua            $(LIBDIR)/Coat/Persistent.lua

install.lsqlite3:
	$(INSTALL) -m 644 -D src.lsqlite3/Coat/Persistent.lua   $(LIBDIR)/Coat/Persistent.lua

uninstall:
	rm -f $(LIBDIR)/Coat/Persistent.lua

manifest_pl := \
use strict; \
use warnings; \
my @files = qw{MANIFEST}; \
while (<>) { \
    chomp; \
    next if m{^\.}; \
    next if m{^debian/}; \
    next if m{^rockspec/}; \
    push @files, $$_; \
} \
print join qq{\n}, sort @files;

rockspec_pl := \
use strict; \
use warnings; \
use Digest::MD5; \
open my $$FH, q{<}, q{$(TARBALL)} \
    or die qq{Cannot open $(TARBALL) ($$!)}; \
binmode $$FH; \
my %config = ( \
    version => q{$(VERSION)}, \
    rev     => q{$(REV)}, \
    md5     => Digest::MD5->new->addfile($$FH)->hexdigest(), \
); \
close $$FH; \
while (<>) { \
    s{@(\w+)@}{$$config{$$1}}g; \
    print; \
}

version:
	@echo $(VERSION)

CHANGES: dist.info
	perl -i.bak -pe "s{^$(VERSION).*}{q{$(VERSION)  }.localtime()}e" CHANGES

dist.info:
	perl -i.bak -pe "s{^version.*}{version = \"$(VERSION)\"}" dist.info

tag:
	git tag -a -m 'tag release $(VERSION)' $(VERSION)

MANIFEST:
	git ls-files | perl -e '$(manifest_pl)' > MANIFEST

$(TARBALL): MANIFEST
	[ -d lua-CoatPersistent-$(VERSION) ] || ln -s . lua-CoatPersistent-$(VERSION)
	perl -ne 'print qq{lua-CoatPersistent-$(VERSION)/$$_};' MANIFEST | \
	    tar -zc -T - -f $(TARBALL)
	rm lua-CoatPersistent-$(VERSION)

dist: $(TARBALL)

rockspec: $(TARBALL)
	perl -e '$(rockspec_pl)' rockspec.luasql.in   > rockspec/lua-coatpersistent-luasql-$(VERSION)-$(REV).rockspec
	perl -e '$(rockspec_pl)' rockspec.lsqlite3.in > rockspec/lua-coatpersistent-lsqlite3-$(VERSION)-$(REV).rockspec

rock:
	luarocks pack rockspec/lua-coatpersistent-luasql-$(VERSION)-$(REV).rockspec
	luarocks pack rockspec/lua-coatpersistent-lsqlite3-$(VERSION)-$(REV).rockspec

deb:
	echo "lua-coatpersistent ($(shell git describe --dirty)) unstable; urgency=medium" >  debian/changelog
	echo ""                         >> debian/changelog
	echo "  * UNRELEASED"           >> debian/changelog
	echo ""                         >> debian/changelog
	echo " -- $(shell git config --get user.name) <$(shell git config --get user.email)>  $(shell date -R)" >> debian/changelog
	fakeroot debian/rules clean binary

ifdef LUA_PATH
  export LUA_PATH:=$(LUA_PATH);../test/?.lua
else
  export LUA_PATH=;;../test/?.lua
endif
#export GEN_PNG=1

check: test

test: test.luasql test.lsqlite3

test.luasql:
	cd src && prove --exec=$(LUA) ../test/*.t

test.lsqlite3:
	cd src.lsqlite3 && prove --exec=$(LUA) ../test/*.t

luacheck:
	luacheck --std=max --codes src --ignore 211/_ENV 212/t 421/cond
	luacheck --std=max --codes src.lsqlite3 --ignore 211/_ENV 212/t 231/err
	luacheck --std=min --config .test.luacheckrc test/*.t

coverage:
	rm -f src/luacov.stats.out src/luacov.report.out
	cd src && prove --exec="$(LUA) -lluacov" ../test/*.t
	cd src && luacov

coveralls:
	rm -f src/luacov.stats.out src/luacov.report.out
	cd src && prove --exec="$(LUA) -lluacov" ../test/*.t
	cd src && luacov-coveralls -e /HERE/ -e %.t$

README.html: README.md
	Markdown.pl README.md > README.html

gh-pages:
	mkdocs gh-deploy --clean

clean:
	rm -f MANIFEST *.bak *.db src/luacov.*.out src/*.db src/*.png test/*.png *.rockspec README.html

realclean: clean

.PHONY: test rockspec deb CHANGES dist.info

