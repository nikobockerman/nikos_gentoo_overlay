# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils mozextension

DESCRIPTION="Mozilla plugin for voikko spellchecker"
HOMEPAGE="http://voikko.sf.net"
#SRC_URI="http://www.puimula.org/htp/testing/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/voikko/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/voikko
	www-client/firefox"
#DEPEND="app-text/voikko
#	net-libs/xulrunner"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/${MY_P/rc?/}"

src_prepare() {
	#epatch ${FILESDIR}/fix_makefile.patch
	rm Makefile
}

#src_compile() {
#	emake mozvoikko2
#	emake -f Makefile.xulrunner\
#		XULRUNNER_SDK=/usr/include/xulrunner-$(best_version \
#		net-libs/xulrunner)/ || die "emake failed"
#}


src_install() {
#	xpi_install $S/${PN}2.xpi
	MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
	xpi_install .
#	emake -f Makefile.xulrunner\
#		DESTDIR="${D}/usr/lib/mozilla-firefox/extensions/" \
#		install-unpacked || die "install failed"
#	dodoc README README.xulrunner ChangeLog || die "docs missing"
}
