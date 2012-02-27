# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/unetbootin/unetbootin-549.ebuild,v 1.3 2011/05/24 21:05:19 maekke Exp $

EAPI="3"

inherit qt4-r2

DESCRIPTION="To create a bootable Live USB drive for Clonezilla live, DRBL live, Gparted live and Tux2live."
HOMEPAGE="http://tuxboot.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

#S="${WORKDIR}/${P}"

DEPEND="x11-libs/qt-gui"
RDEPEND="${DEPEND}
		 sys-fs/mtools
		 sys-boot/syslinux
		 app-arch/p7zip"

MY_PN="unetbootin"

src_prepare() {
	sed -i '/^RESOURCES/d' ${MY_PN}.pro
	rm ${MY_PN}_da.ts
}

src_configure() {
	lupdate ${MY_PN}.pro || die
	lrelease ${MY_PN}.pro || die
	eqmake4 "DEFINES += NOSTATIC CLONEZILLA" "RESOURCES -= unetbootin.qrc" ${MY_PN}.pro || die
	#eqmake4 ${MY_PN}.pro || die
}

src_install() {
	dobin ${PN} || die
	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop" || die
	#for file in ${PN}*.png; do
	#	size="${file/unetbootin_}"
	#	size="${size/.png}x${size/.png}"
	#	insinto /usr/share/icons/hicolor/${size}
	#	newins ${file} ${PN}.png
	#done
}
