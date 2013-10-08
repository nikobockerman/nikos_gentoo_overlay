# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python3_2)
inherit distutils-r1

DESCRIPTION="Wrapper for rsnapshot"
HOMEPAGE="https://github.com/nikobockerman/rsnapshot-backup"
SRC_URI="mirror://github/nikobockerman/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/psutil
	app-backup/rsnapshot
	sys-apps/util-linux"

python_install_all() {
	distutils-r1_python_install_all
	dodoc README

	insinto /etc/rsnapshot-backup
	doins etc/rsnapshot-backup/emailsettings.cfg
	insinto /etc/rsnapshot-backup/example
	doins etc/rsnapshot-backup/example/settings.cfg
	doins etc/rsnapshot-backup/example/rsnapshot.conf
}
