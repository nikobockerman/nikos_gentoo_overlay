# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

PATCHVER="1.1"
ELF2FLT_VER=""
inherit toolchain-binutils

KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"

src_unpack() {
	toolchain-binutils_src_unpack
	epatch "${FILESDIR}/avr-size.patch"
}
