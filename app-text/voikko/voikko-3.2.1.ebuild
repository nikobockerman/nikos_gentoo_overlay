# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_P=lib${P/_rc/rc}

DESCRIPTION="Free Finnish spellchecking and hyphenation library"
HOMEPAGE="http://voikko.sf.net"
#SRC_URI="http://www.puimula.org/htp/testing/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/voikko/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-misc/malaga
	>=sci-misc/suomi-malaga-1.4
	virtual/libiconv"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P/rc?/}"

src_compile() {
	econf CXXFLAGS=-Wno-error || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README || die "docs missing"
}
