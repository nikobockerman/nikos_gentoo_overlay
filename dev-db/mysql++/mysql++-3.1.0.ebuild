# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql++/mysql++-3.0.9.ebuild,v 1.3 2011/11/08 10:22:20 grobian Exp $

EAPI="4"

inherit eutils flag-o-matic

DESCRIPTION="C++ API interface to the MySQL database"
HOMEPAGE="http://tangentsoft.net/mysql++/"
SRC_URI="http://www.tangentsoft.net/mysql++/releases/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86 ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="custom"

RDEPEND=">=virtual/mysql-4.0"
DEPEND="${RDEPEND}
		|| ( >=sys-devel/gcc-3 >=sys-devel/gcc-apple-4 )"

src_prepare() {
	epatch "${FILESDIR}"/gcc_43.patch
	#if use custom_patch ; then
	#	epatch "${FILESDIR}"/custom.patch
	#fi

	for i in "${S}"/lib/*.h ; do
		sed -i \
			-e '/#include </s,mysql.h,mysql/mysql.h,g' \
			-e '/#include </s,mysql_version.h,mysql/mysql_version.h,g' \
			"${i}" || die "Failed to sed ${i} for fixing MySQL includes"
	done
}

src_configure() {
	local myconf
	#use prefix || local EPREFIX=
	myconf="--enable-exceptions --enable-thread-check"

	if use custom ; then
		myconf="${myconf} --with-field-limit=71"
	fi

	filter-ldflags -Wl,--as-needed

	#CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	# install the docs and HTML pages
	dodoc README* CREDITS* COPYING* ChangeLog HACKERS* INSTALL* LICENSE* Wishlist
	dodoc -r doc/*
	#cp -ra doc/html "${D%/}${EPREFIX}"/usr/share/doc/${PF}/html
}
