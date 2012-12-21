# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/unetbootin/unetbootin-549.ebuild,v 1.3 2011/05/24 21:05:19 maekke Exp $

EAPI="5"

LANGS="am ar ast bg be bn ca cs de da el eo es et fi fo fr gl he hu id it ja lt lv ml ms nan nb nl pl pt ro ru sk sl sv tr uk vi"
LANGSLONG="pt_BR zh_CN zh_TW"

inherit qt4-r2

DESCRIPTION="To create a bootable Live USB drive for Clonezilla live, DRBL live, Gparted live and Tux2live."
HOMEPAGE="http://tuxboot.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

#S="${WORKDIR}/${P}"

DEPEND="x11-libs/qt-gui
		x11-libs/qt-core"
RDEPEND="${DEPEND}
		 sys-fs/mtools
		 sys-boot/syslinux
		 app-arch/p7zip"

DOCS=( ChangeLog README.TXT )


src_prepare() {
	echo "DEFINES += NOSTATIC" >> ${PN}.pro
	for lang in ${LANGS}; do
		if ! use linguas_${lang}; then
			rm -f "i18n/${PN}_${lang}."*
			sed -i -e "s:i18n\/${PN}_${lang}.ts::" "${PN}.pro" || die
			sed -i -e "/i18n\/${PN}_${lang}.qm/d" "${PN}.qrc" || die
		fi
	done
	for lang in ${LANGSLONG}; do
		if ! use linguas_${lang%_*}; then
			rm -f "i18n/${PN}_${lang}."*
			sed -i -e "s:i18n\/${PN}_${lang}.ts::" "${PN}.pro" || die
			sed -i -e "/i18n\/${PN}_${lang}.qm/d" "${PN}.qrc" || die
		fi
	done
}

src_configure() {
	lupdate ${PN}.pro || die
	lrelease ${PN}.pro || die
	qt4-r2_src_configure
}

src_install() {
	qt4-r2_src_install
	dobin ${PN} || die
	doman "debian/${PN}.1"

	insinto /usr/share/applications
	doins "${PN}.desktop" || die
	
	insinto /usr/share/pixmaps
	doins "${PN}.xpm" || die
	
	insinto /usr/share/${PN}
	doins i18n/*.qm
}
