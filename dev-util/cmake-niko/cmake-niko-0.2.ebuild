# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Nikos cmake find scripts"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-util/cmake"

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

