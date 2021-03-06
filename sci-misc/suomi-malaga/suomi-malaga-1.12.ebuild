# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

DESCRIPTION="Finnish wordform patterns for malaga"
HOMEPAGE="http://voikko.sf.net/"
SRC_URI="mirror://sourceforge/voikko/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=sci-misc/malaga-7.8
	sys-apps/grep
	sys-apps/sed
	=dev-lang/python-2*"
RDEPEND="sci-misc/malaga"

src_compile() {
	emake \
		GENLEX_OPTS="--extra-usage=science" \
		EXTRA_LEX="vocabulary/erikoisalat/linux-distributions.lex \
			vocabulary/erikoisalat/atk-lyhenteet.lex" \
		PYTHON="python2" \
		voikko || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}"/usr/lib/voikko/ voikko-install || die "install failed"
	dodoc ChangeLog README.fi README CONTRIBUTORS || die "docs missing"
}
