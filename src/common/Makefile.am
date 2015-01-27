# Copyright 1999-2014 the Claws Mail team.
# This file is part of Claws Mail package, and distributed under the
# terms of the General Public License version 3 (or later).
# See COPYING file for license details.

PLUGINDIR = $(pkglibdir)/plugins/
DESKTOPFILEPATH=$(datadir)/applications/sylpheedish.desktop

noinst_LTLIBRARIES = libsylpheedishcommon.la

if OS_WIN32
arch_sources = fnmatch.c \
               w32_dirent.c w32_reg.c w32_signal.c w32_stat.c \
               w32_stdio.c w32_stdlib.c w32_string.c w32_time.c \
               w32_unistd.c w32_wait.c w32_account.c
arch_headers = fnmatch.h w32lib.h
else
arch_files = 
arch_header = 
endif

libsylpheedishcommon_la_SOURCES = $(arch_sources) \
	hooks.c \
	log.c \
	md5.c \
	mgutils.c \
	passcrypt.c \
	plugin.c \
	prefs.c \
	progressindicator.c \
	quoted-printable.c \
	session.c \
	smtp.c \
	socket.c \
	ssl.c \
	ssl_certificate.c \
	string_match.c \
	stringtable.c \
	sylpheedish.c \
	tags.c \
	template.c \
	utils.c \
	uuencode.c \
	xml.c \
	xmlprops.c

sylpheedishcommonincludedir = $(pkgincludedir)/common
sylpheedishcommoninclude_HEADERS = $(arch_headers) \
	defs.h \
	hooks.h \
	log.h \
	md5.h \
	mgutils.h \
	passcrypt.h \
	plugin.h \
	prefs.h \
	progressindicator.h \
	quoted-printable.h \
	session.h \
	smtp.h \
	socket.h \
	ssl_certificate.h \
	ssl.h \
	string_match.h \
	stringtable.h \
	sylpheedish.h \
	tags.h \
	template.h \
	timing.h \
	utils.h \
	uuencode.h \
	version.h \
	xml.h \
	xmlprops.h

AM_CPPFLAGS = \
	-I$(top_srcdir)/intl \
	$(GLIB_CFLAGS) \
	$(VALGRIND_CFLAGS) \
	-DLOCALEDIR=\""$(localedir)"\" \
	-DPLUGINDIR=\"$(PLUGINDIR)\" \
	-DDATAROOTDIR=\""$(datarootdir)"\" \
	-DDESKTOPFILEPATH=\"$(DESKTOPFILEPATH)\" \
	-DGTK_DISABLE_DEPRECATED

libsylpheedishcommon_la_LIBADD = \
	$(GLIB_LIBS) \
	$(CRYPT_LIBS) \
	$(PTHREAD_LIBS)

EXTRA_DIST = \
	version.h.in fnmatch_loop.c

