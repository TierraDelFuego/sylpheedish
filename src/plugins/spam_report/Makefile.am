# Copyright 1999-2014 the Claws Mail team.
# This file is part of Claws Mail package, and distributed under the
# terms of the General Public License version 3 (or later).
# See COPYING file for license details.

EXTRA_DIST = claws.def plugin.def version.rc

IFLAGS = \
	-I$(top_srcdir)/src \
	-I$(top_srcdir)/src/common \
	-I$(top_builddir)/src/common \
	-I$(top_srcdir)/src/gtk

if OS_WIN32

LTRCCOMPILE = $(LIBTOOL) --mode=compile --tag=RC $(RC) \
     `echo $(DEFS) $(DEFAULT_INCLUDES) $(IFLAGS) | \
     sed -e 's/-I/--include-dir /g;s/-D/--define /g'`

+.rc.lo:
	$(LTRCCOMPILE) -i $< -o $@

plugin_res = version.lo
plugin_res_ldflag = -Wl,.libs/version.o

export_symbols = -export-symbols $(srcdir)/plugin.def

plugin_deps = libclaws.a $(plugin_res) plugin.def

libclaws.a: claws.def
	$(DLLTOOL) --output-lib $@ --def $<

plugin_ldadd = -L. -lclaws

else
plugin_res =
plugin_res_ldflag =
export_symbols =
plugin_deps =
plugin_ldadd =
endif

if PLATFORM_WIN32
no_undefined = -no-undefined
else
no_undefined =
endif

if CYGWIN
cygwin_export_lib = -L$(top_builddir)/src -lclaws-mail
else
cygwin_export_lib = 
endif

plugindir = $(pkglibdir)/plugins

if BUILD_SPAM_REPORT_PLUGIN
plugin_LTLIBRARIES = spamreport.la
endif

spamreport_la_SOURCES = \
         spam_report.c \
	 spam_report_prefs.c \
	 spam_report_prefs.h

spamreport_la_LDFLAGS = \
	$(plugin_res_ldflag) $(no_undefined) $(export_symbols) \
	-avoid-version -module \
	$(GTK_LIBS)

spamreport_la_LIBADD = $(plugin_ldadd) $(cygwin_export_lib) \
	$(CURL_LIBS) \
	$(GTK_LIBS)

spamreport_la_DEPENDENCIES = $(plugin_deps)

spamreport_la_CPPFLAGS = \
	$(IFLAGS) \
	$(GLIB_CFLAGS) \
	$(CURL_CFLAGS) \
	$(GTK_CFLAGS)
