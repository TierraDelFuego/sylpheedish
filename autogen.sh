#!/bin/sh
# Copyright 1999-2014 the Claws Mail team.
# This file is part of Claws Mail package, and distributed under the
# terms of the General Public License version 3 (or later).
# See COPYING file for license details.

# ***** W32 build script *******
# Used to cross-compile for Windows.
if test "$1" = "--build-w32"; then
    tmp=`dirname $0`
    tsdir=`cd "$tmp"; pwd`
    shift
    if [ ! -f $tsdir/config/config.guess ]; then
        echo "$tsdir/config/config.guess not found" >&2
        exit 1
    fi
    build=`$tsdir/config/config.guess`

    [ -z "$w32root" ] && w32root="$HOME/w32root"
    echo "Using $w32root as standard install directory" >&2
    
    if i586-mingw32msvc-gcc --version >/dev/null 2>&1 ; then
        host=i586-mingw32msvc
        crossbindir=/usr/$host/bin
    else
       echo "Debian's mingw32 cross-compiler packet is required" >&2
       exit 1
    fi
   
    if [ -f "$tsdir/config.log" ]; then
        if ! head $tsdir/config.log | grep "$host" >/dev/null; then
            echo "Pease run a 'make distclean' first" >&2
            exit 1
        fi
    fi

    ./configure --enable-maintainer-mode --prefix=${w32root}  \
             --host=i586-mingw32msvc --build=${build} \
             --with-lib-prefix=${w32root} \
             --with-libiconv-prefix=${w32root} \
             --with-gpg-error-prefix=${w32root} \
	     --with-gpgme-prefix=${w32root} \
             --with-config-dir="Claws-mail" \
             --disable-openssl --disable-dillo-viewer-plugin \
             --disable-nls --disable-libetpan --disable-enchant \
             --disable-trayicon-plugin --disable-spamassassin-plugin \
             --disable-bogofilter-plugin --disable-valgrind \
             PKG_CONFIG_LIBDIR="$w32root/lib/pkgconfig"

    rc=$?
    exit $rc
fi
# ***** end W32 build script *******

bisonver=`bison --version`

if [ "$bisonver" = "" ]; then
	echo Bison is needed to compile Claws Mail git
	exit 1
fi

if [ "$LEX" != "" ]; then
	flexver=`$LEX --version|sed "s/.* //"`
else
	flexver=`flex --version|sed "s/.* //"`
fi

if [ "$flexver" = "" ]; then
	echo Flex 2.5.31 or greater is needed to compile Claws Mail git
	exit 1
else
	flex_major=`echo $flexver|sed "s/\..*//"`
	flex_minor=`echo $flexver|sed "s/$flex_major\.\(.*\)\..*/\1/"`
	flex_micro=`echo $flexver|sed "s/$flex_major\.$flex_minor\.\(.*\)/\1/"`
	if [ $flex_major -lt 2 -o $flex_minor -lt 5 -o $flex_micro -lt 31 ]; then
		echo Flex 2.5.31 or greater is needed to compile Claws Mail git
		exit 1
	fi
fi

aclocal -I m4 \
  && libtoolize --force --copy \
  && autoheader \
  && automake --add-missing --foreign --copy \
  && autoconf 

if test -z "$LOCAL"; then
    echo No LOCAL dir set using /usr/local
    LOCAL="/usr/local"
fi

export PATH=${LOCAL}/libetpan/bin:${PATH}
exec ./configure --enable-static \
--enable-gnutls \
--disable-shared \
--prefix=${LOCAL}/sylpheedish \
--disable-ipv6 \
--disable-manual \
--disable-libsm \
--enable-libetpan \
--disable-generic-umpc \
--enable-pthread \
--disable-enchant  \
--disable-compface \
--disable-startup-notification \
--disable-dbus \
--disable-ldap \
--disable-jpilot \
--disable-networkmanager \
--disable-valgrind \
--disable-att_remover-plugin \
--disable-attachwarner-plugin \
--disable-bogofilter-plugin  \
--disable-bsfilter-plugin     \
--disable-clamd-plugin       \
--disable-fancy-plugin       \
--disable-fetchinfo-plugin   \
--disable-gdata-plugin       \
--disable-geolocation-plugin  \
--disable-libravatar-plugin   \
--disable-mailmbox-plugin     \
--disable-newmail-plugin      \
--disable-notification-plugin \
--disable-pdf_viewer-plugin   \
--disable-perl-plugin         \
--disable-python-plugin       \
--disable-smime-plugin        \
--disable-spamassassin-plugin \
--disable-spam_report-plugin  \
--disable-rssyl-plugin \
--disable-archive-plugin \
--disable-python-plugin \
--enable-new-addrbook

