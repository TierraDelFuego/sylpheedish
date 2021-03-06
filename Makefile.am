# Copyright 1999-2015 TierraDelFuego, the Claws Mail team.
# This file is part of Claws Mail package, and distributed under the
# terms of the General Public License version 3 (or later).
# See COPYING file for license details.

ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = dist-xz

SUBDIRS = m4 po src tools config doc manual

EXTRA_DIST = \
	Changelog \
	RELEASE_NOTES \
	claws-mail-128x128.png \
	claws-mail-64x64.png \
	sylpheedish.pc.in \
	sylpheedish.desktop \
	claws-mail.png \
	autogen.sh \
	sylpheedish-features.h.in \
	version

# hicolor icon theme, base class of all icon themes
pixmapdir=$(datadir)/icons/hicolor/48x48/apps
pixmap_DATA=claws-mail.png

pixmap64dir=$(datadir)/icons/hicolor/64x64/apps
pixmap64_DATA=claws-mail-64x64.png

pixmap128dir=$(datadir)/icons/hicolor/128x128/apps
pixmap128_DATA=claws-mail-128x128.png


rename-icons:
	@cd $(DESTDIR)$(datadir)/icons/hicolor/64x64/apps && \
            mv claws-mail-64x64.png claws-mail.png
	@cd $(DESTDIR)$(datadir)/icons/hicolor/128x128/apps && \
            mv claws-mail-128x128.png claws-mail.png

remove-icons:
	rm -f $(DESTDIR)$(datadir)/icons/hicolor/64x64/apps/claws-mail.png
	rm -f $(DESTDIR)$(datadir)/icons/hicolor/128x128/apps/claws-mail.png

if UPDATE_GTK_ICON_CACHE
gtk_update_icon_cache = gtk-update-icon-cache -f -t $(datadir)/icons/hicolor

install-data-hook: rename-icons update-icon-cache
uninstall-hook: remove-icons update-icon-cache

update-icon-cache:
	@-if test -z "$(DESTDIR)"; then					\
                echo "Updating Gtk icon cache.";			\
                $(gtk_update_icon_cache);				\
        else								\
                echo "*** Icon cache not updated. Remember to run:";	\
		echo "***";						\
                echo "***   $(gtk_update_icon_cache)";			\
		echo "***";						\
        fi
else

install-data-hook: rename-icons
uninstall-hook: remove-icons

endif

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = sylpheedish.pc

sylpheedishincludedir = $(pkgincludedir)
sylpheedishinclude_HEADERS = \
	sylpheedish-features.h

relnotesdir = $(docdir)
relnotes_DATA = RELEASE_NOTES

# when changing the name or location of the .desktop file,
# also update src/common/Makefile.am

desktopdir = $(datadir)/applications
desktop_DATA = sylpheedish.desktop

install-data-local:
    @$(NORMAL_INSTALL)
