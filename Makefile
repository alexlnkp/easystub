PREFIX = /usr
MAINUSER = $$(whoami)
EASYSTUB_CONF_FILE_PATH = /home/$(MAINUSER)/.config/easystub/config.conf

.PHONY: all

all: check-user
	@echo Run 'make install' to install EasySTUB.

.PHONY: check-user

check-user:
	@if [ $(MAINUSER) = "root" ]; then \
	    echo "Do NOT run make as a root."; \
	    exit 1; \
	fi

install: check-user
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@chmod +x easystub
	@sudo cp -p easystub $(DESTDIR)$(PREFIX)/bin/easystub
	
	@mkdir -p /home/$(MAINUSER)/.config/easystub
	@cp -u -p example.conf $(EASYSTUB_CONF_FILE_PATH)
	@export EASYSTUB_CONF_FILE_PATH=$(EASYSTUB_CONF_FILE_PATH)

uninstall: check-user
	@rm -rI $(DESTDIR)$(PREFIX)/bin/easystub
	@rm -rI /home/$(MAINUSER)/.config/easystub