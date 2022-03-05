SHELL = /bin/sh

NONROOT_INSTALL_DIR = ~/.local/bin/
ROOT_INSTALL_DIR = /usr/bin/
IN_NAME = ffetch.sh
OUT_NAME = ffetch

help:
	@echo Use make install to install systemwide
	@echo Use make install-nonroot to install for current user
	@echo Use make config to copy the default config to ~/.ffetchrc

install:
	cp ${IN_NAME} ${ROOT_INSTALL_DIR}${OUT_NAME}

install-nonroot:
	cp ${IN_NAME} ${NONROOT_INSTALL_DIR}${OUT_NAME}

config:
	cp ffetchrc ~/.ffetchrc
