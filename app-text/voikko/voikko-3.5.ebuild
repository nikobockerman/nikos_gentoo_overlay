# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit eutils

MY_P=lib${P}

DESCRIPTION="Free Finnish spellchecking and hyphenation library"
HOMEPAGE="http://voikko.sf.net"
#SRC_URI="http://www.puimula.org/htp/testing/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/voikko/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sci-misc/malaga
	>=sci-misc/suomi-malaga-1.4
	virtual/libiconv"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	=dev-lang/python-2*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "$FILESDIR/python2.diff"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README || die "docs missing"
	rm "${D}"/usr/$(get_libdir)/*.la
	rm "${D}"/usr/$(get_libdir)/*.a
}
