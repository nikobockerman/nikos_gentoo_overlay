# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

DESCRIPTION="Linguistic morphological programming language and toolset"
HOMEPAGE="http://home.arcor.de/bjoern-beutel/malaga/"
SRC_URI="http://home.arcor.de/bjoern-beutel/malaga/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk doc readline emacs"

DEPEND=">=dev-libs/glib-2.0
	gtk? ( >=x11-libs/gtk+-2.8 )
	doc? ( >=sys-apps/texinfo-4.0 )
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

src_compile() {
	econf $(use_with readline ) $(use_enable gtk malshow ) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc CHANGES.txt INSTALL.txt README.txt
}

pkg_postinst() {
	if use emacs ; then
		einfo "If you are using Emacs, add the line"
		einfo "	(require 'malaga \"${ROOT}/usr/share/malaga/malaga.el\")"
		einfo "to the file \".emacs\" in your home directory, "
		einfo "so the Malaga extensions will be loaded automatically "
		einfo "if you are starting Emacs."
	fi
}
