
EAPI=4

inherit eutils

DESCRIPTION="Scripts for Samsung netbooks"
HOMEPAGE="http://www.voria.org/forum"
SRC_URI=""

LICENCE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="kde-base/khotkeys"
RDEPEND="sys-apps/vbetool"

src_unpack() {
	mkdir $S
}

src_install() {
	dobin ${FILESDIR}/scripts/${PN}
	exeinto /usr/lib/${PN}
	doexe ${FILESDIR}/scripts/lcd.sh
	insinto /etc/sudoers.d
	doins ${FILESDIR}/sudoers.d/${PN}
	fperms 0440 /etc/sudoers.d/${PN}

	insinto /usr/share/apps/khotkeys
	doins ${FILESDIR}/khotkeys/samsung-scripts.khotkeys
}
