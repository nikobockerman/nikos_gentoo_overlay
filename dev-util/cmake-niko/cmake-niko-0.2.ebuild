# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Nikos cmake find scripts"
HOMEPAGE="http://github.com/nikobockerman/nikos_gentoo_overlay/"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake"

CMAKE_MODULES="FindMySQL++.cmake
		FindMYSQL.cmake
		FindCppUnit.cmake"

S="${WORKDIR}"
src_install() {
	insinto /usr/share/cmake/Modules
	for module in $CMAKE_MODULES
	do
		doins "${FILESDIR}"/"$module"
	done
}
