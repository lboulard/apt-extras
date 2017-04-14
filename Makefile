
SOURCES=sources.list.d/laurent-boulard-ubuntu-vim.list
SOURCES+=sources.list.d/laurent-boulard-ubuntu-i3.list
SOURCES+=sources.list.d/laurent-boulard-ubuntu-devtools.list
SOURCES+=sources.list.d/laurent-boulard-ubuntu-fonts.list
SOURCES+=sources.list.d/sur5r-i3.list
SOURCES+=sources.list.d/sur5r-rofi.list
SOURCES+=sources.list.d/git-core-ubuntu-ppa.list

KEYS=trusted.gpg.d/laurent-boulard_ubuntu.gpg.asc
KEYS+=trusted.gpg.d/git-core_ubuntu.gpg.asc

DIST:=$(shell lsb_release -sc || echo sid)

DIST_SOURCES=$(SOURCES:%.list=%-$(DIST).list)
DIST_KEYS=$(KEYS:%.asc=%)
DIST_KEYS+=trusted.gpg.d/sur5r-keyring-2015.gpg

SUDOERS=sudoers.d/pbuilder

APT_DIR=$(DESTDIR)/etc/apt

build: build-sources build-keys

build-sources: $(DIST_SOURCES)
build-keys: $(DIST_KEYS)

%-$(DIST).list: %.list
	sed -e "s/\$$DIST/$(DIST)/" $< >"$@"

%: %.asc
	gpg --no-default-keyring --keyring $@ --import $<

install-sources:
	@install -v -d -m755 "$(APT_DIR)/sources.list.d"
	@install -v -m644 $(DIST_SOURCES) "$(APT_DIR)/sources.list.d"

install-keys:
	@install -v -d -m 755 "$(APT_DIR)/trusted.gpg.d"
	@install -v -m644 $(DIST_KEYS) "$(APT_DIR)/trusted.gpg.d"

install-sudoers:
	@install -v -d -m750 "$(DESTDIR)/etc/sudoers.d"
	@install -v -m440 $(SUDOERS) "$(DESTDIR)/etc/sudoers.d"

install: install-sources install-keys install-sudoers

# Do not use DIST_... variables, they may reference static files
clean:
	rm -f $(SOURCES:%.list=%-$(DIST).list)
	rm -f $(KEYS:%.asc=%)

HTTP_UBUNTU_KEYSERVER=http://keyserver.ubuntu.com:80/pks/lookup?op=get&search=

# https://launchpad.net/~laurent-boulard/
#  key fingerprint: 0x1AFEFE644F82D365
fetch-keys:
	scripts/fetch-key "$(HTTP_UBUNTU_KEYSERVER)0x1AFEFE644F82D365" >trusted.gpg.d/laurent-boulard_ubuntu.gpg.asc
	scripts/fetch-key "$(HTTP_UBUNTU_KEYSERVER)0xA1715D88E1DF1F24" >trusted.gpg.d/git-core_ubuntu.gpg.asc

.PHONY: clean fetch-keys
