SHELL = /bin/sh

INSTALL_DIR = /usr/bin/
IN_NAME = zfetch.sh
OUT_NAME = zfetch

help:
	@echo "make install      Install zfetch."
	@echo "make uninstall    Remove zfetch."
	@echo "make rmconfig     Remove zfetch configuration files."

install:
	cp ${IN_NAME} ${INSTALL_DIR}${OUT_NAME}
	[ -e /etc/zshrc ] || cp zfetchrc /etc/zfetchrc

uninstall:
	rm ${INSTALL_DIR}${OUT_NAME}

rmconfig:
	rm /etc/zfetchrc
