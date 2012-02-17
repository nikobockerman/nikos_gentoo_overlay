# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_P=lib${P/_rc/rc}

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
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P/rc?/}"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README || die "docs missing"
	rm $D/usr/$(get_libdir)/*.la
	rm $D/usr/$(get_libdir)/*.a
}
