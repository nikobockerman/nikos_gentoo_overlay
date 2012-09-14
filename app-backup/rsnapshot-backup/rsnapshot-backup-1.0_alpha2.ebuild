# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_COMPAT='python3_2'
inherit python-distutils-ng

DESCRIPTION="Wrapper for rsnapshot"
HOMEPAGE="https://github.com/nikobockerman/rsnapshot-backup"
SRC_URI="https://github.com/downloads/nikobockerman/${PN}/${P}.tar.gz"

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
	dodoc README
	dodoc COPYING

	insinto /etc/rsnapshot-backup
	doins etc/rsnapshot-backup/emailsettings.cfg
	insinto /etc/rsnapshot-backup/example
	doins etc/rsnapshot-backup/example/settings.cfg
	doins etc/rsnapshot-backup/example/rsnapshot.conf
}
