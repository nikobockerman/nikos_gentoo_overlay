# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

if [ "${ARCH}" = "amd64" ] ; then
	LNXARCH="linux-x86_64"
	MENARCH="x86_64"
else
	LNXARCH="linux-i486"
	MENARCH="i486"
fi

DESCRIPTION="A free research management tool for desktop & web"
HOMEPAGE="http://www.mendeley.com/"
SRC_URI="http://www.mendeley.com/downloads/linux/${P}-${LNXARCH}.tar.bz2"

LICENSE="Mendeley-EULA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="media-libs/libpng:1.2
		dev-libs/openssl:0.9.8"

S="${WORKDIR}/${P}-${LNXARCH}"

MENDELEY_INSTALL_DIR="/opt/${PN}"

#MENDELEY_LIBS="

src_install() {
	# install menu
	domenu ${S}/share/applications/${PN}.desktop || die "Installing desktop files failed."
	# Install commonly used icon sizes
	for res in 16x16 22x22 32x32 48x48 64x64 128x128 ; do
		insinto /usr/share/icons/hicolor/${res}/apps
		doins share/icons/hicolor/${res}/apps/${PN}.png || die "Installing icons failed."
	done
	insinto /usr/share/pixmaps
	doins share/icons/hicolor/48x48/apps/${PN}.png || die "Installing pixmap failed."


	# dodoc
	dodoc ${S}/share/doc/${PN}/* || die "Installing docs failed."

	dodir ${MENDELEY_INSTALL_DIR}
	dodir ${MENDELEY_INSTALL_DIR}/lib
	dodir ${MENDELEY_INSTALL_DIR}/share
	#mv ${S}/share/icons ${D}/usr/share
	mv ${S}/bin ${D}${MENDELEY_INSTALL_DIR} || die "Installing bin failed."

	# Install libraries
	mv ${S}/lib ${D}${MENDELEY_INSTALL_DIR} || die "Installing libs failed."
	#mv ${S}/lib/libMendeley.so*  ${D}${MENDELEY_INSTALL_DIR}/lib || die "Installing libs failed."
	#dodir ${MENDELEY_INSTALL_DIR}/lib/${PN}
	#dodir ${MENDELEY_INSTALL_DIR}/lib/${PN}/libexec
	#mv ${S}/lib/${PN}/libexec/${PN}.${MENARCH} ${D}${MENDELEY_INSTALL_DIR}/lib/${PN}/libexec/ || die "Installing libs failed"
	#mv ${S}/lib/${PN}/libexec/qt.conf ${D}${MENDELEY_INSTALL_DIR}/lib/${PN}/libexec/ || die "Installing libs failed"
	#mv ${S}/lib/${PN}/libexec/Updater ${D}${MENDELEY_INSTALL_DIR}/lib/${PN}/libexec/ || die "Installing libs failed"
	#mv ${S}/lib/libPDFNetC.so ${D}${MENDELEY_INSTALL_DIR}/lib/ || die "Installing libs failed"
	#mv ${S}/lib/libpng.so.3 ${D}${MENDELEY_INSTALL_DIR}/lib/ || die "Installing libs failed"
	#mv ${S}/lib/libssl.so.0 ${D}${MENDELEY_INSTALL_DIR}/lib/ || die "Installing libs failed"
	#dodir ${MENDELEY_INSTALL_DIR}/lib/${PN}/plugins
	#dodir ${MENDELEY_INSTALL_DIR}/lib/${PN}/plugins/sqldrivers
	#mv ${S}/lib/${PN}/plugins/sqldrivers/libqsqlite.so ${D}${MENDELEY_INSTALL_DIR}/lib/${PN}/plugins/sqldrivers/ || die "Installing libs failed"
	##dosym /usr/lib/qt4/plugins/sqldrivers/libqsqlite.so ${MENDELEY_INSTALL_DIR}/lib/${PN}/plugins/sqldrivers/libqsqlite.so || die "Installing qt sql plugin symlink failed."

	#mv ${S}/lib/libQt* ${D}${MENDELEY_INSTALL_DIR}/lib/ || die "Installing libs failed"

	mv ${S}/share/${PN} ${D}${MENDELEY_INSTALL_DIR}/share || die "Installing shared files failed."

	dosym /opt/${PN}/bin/${PN} /opt/bin/${PN} || die "Installing launcher symlinks failed."
	#dosym /usr/lib/libssl.so ${MENDELEY_INSTALL_DIR}/lib/libssl.so.0.9.8 || die	"Installing libssl symlink failed."
}

pkg_postinst() {
	einfo "If you have an error message \"Cannot mix incompatible Qt libraries\","
	einfo "when you run mendeleydesktop, follow the instructions below:"
	echo
	einfo "- To disable the default widget style, run Mendeley with	the "
	einfo "'-style cleanlooks' argument (where 'cleanlooks' can	also be substituted"
	einfo "with 'gtk' or 'plastique' amongst others)."
	echo
	einfo "- To disable the 'platform integration' plugin (new feature in Qt >= 4.6),"
	einfo "set the QT_PLATFORM_PLUGIN environment variable to some nonsense value "
	einfo "(eg. \"ignoreme\") before running Mendeley."
}
