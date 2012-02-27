# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs versionator eutils

# ie 1.2.3.4 => 1.2.3-4

MY_PV=$(replace_version_separator 3 '-')

#MY_PV="${PV%.*}-${PV##*.}"

DESCRIPTION="cups driver for brother printer"
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"

PRINTER_L="HL-2270DW"
PRINTER=${PRINTER_L/-/}
#printer=$(echo ${PRINTER} | awk '{print tolower($1)}')
printer=$(echo ${PRINTER} | tr "[:upper:]" "[:lower:]")
url="http://www.brother.com/pub/bsc/linux/dlf"
SRC_URI="$url/${printer}lpr-2.1.0-1.i386.deb $url/cupswrapper${PRINTER}-${MY_PV}.i386.deb"

LICENSE="GPL-2 as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/psutils
	app-text/a2ps
	app-arch/gzip"
RDEPEND="${DEPEND}"
RESTRICT="mirror strip"

S=$WORKDIR

# @FUNCTION: get_file
# @USAGE: <input file> <output file> <search>
# @DESCRIPTION
# Extracts from <input file> to <output file> limited by <search>
extract_from_installer()
{
	sed "0,/$3/d; /$3/,//d; s:\\\::g" $1 > $2
#	local pos=($(grep -n $3 $1 | sed -e 's:^\([0-9]*\).*$:\1:'))
#	cat $1 | tail -n $(($(cat $1 | wc -l)-${pos[0]})) | \
#		head -n $((${pos[1]}-${pos[0]}-1)) | sed -e "s:\\\::g" > $2
}

PPDFILE="Brother-${PRINTER_L}-lpr.ppd"
WRAPPERFILE="brlpdwrapper${PRINTER}"

src_unpack()
{
	local files=( ${A} )
	unpack "${files[0]}" "./data.tar.gz" "${files[1]}" "./data.tar.gz"
	rm -f control.tar.gz data.tar.gz debian-binary

	local wrapper="usr/local/Brother/Printer/$PRINTER/cupswrapper/cupswrapper${PRINTER}-$(get_version_component_range 1-3)"
	extract_from_installer ${wrapper} $WRAPPERFILE ENDOFWFILTER
	extract_from_installer ${wrapper} ${PPDFILE} ENDOFPPDFILE

	#The driver is missing this file.
	#echo ${PRINTER} >> usr/local/Brother/Printer/$PRINTER/inf/brPrintList

	#rm "${wrapper}"
}

#src_prepare() {
	# /usr/local/Brother isn't a nice path...
	#sed -i -e "s:/usr/local/Brother/Printer:/usr/share/brother:g" $(find . -type f)

	#sed -i -e "s/\(SaveMode:* \)Off/\1OFF/g" \
	#  -e "s/\(SaveMode:* \)On/\1ON/g" ${PPDFILE}
	#gzip ${PPDFILE}
	#PPDFILE="${PPDFILE}.gz"

	#epatch $FILESDIR/brlpdwrapper.patch
	#epatch $FILESDIR/inf_setupPrintcap2.patch
	#epatch $FILESDIR/lpd_filter.patch
#}

#doecho()
#{
#	echo "$@"
#	eval "$@"
#}

#src_compile()
#{
	#doecho $(tc-getCC) ${CFLAGS} -o brcupsconfig3 \
	#	${PN}-${MY_PV}/brcupsconfig3/brcupsconfig.c
	#doecho $(tc-getSTRIP) --strip-unneeded -R .comment brcupsconfig3
#}

src_install()
{
	exeinto /usr/libexec/cups/filter
	doexe $WRAPPERFILE

	#insinto /usr/share/cups/model
	insinto /usr/share/ppd/Brother
	doins ${PPDFILE}
	gzip "${D}/usr/share/ppd/Brother/${PPDFILE}"

	#exeinto /usr/share/brother/$PRINTER/cupswrapper
	exeinto /usr/local/Brother/Printer/$PRINTER/cupswrapper
	doexe usr/local/Brother/Printer/$PRINTER/cupswrapper/brcupsconfig4

	#exeinto /usr/share/brother/$PRINTER/lpd
	exeinto /usr/local/Brother/Printer/$PRINTER/lpd
	doexe usr/local/Brother/Printer/$PRINTER/lpd/*

	#insinto /usr/share/brother/$PRINTER/inf
	insinto /usr/local/Brother/Printer/$PRINTER/inf
	doins usr/local/Brother/Printer/$PRINTER/inf/br$PRINTER*
	doins usr/local/Brother/Printer/$PRINTER/inf/paperinf
	fperms a+w /usr/local/Brother/Printer/$PRINTER/inf
	fperms a+w /usr/local/Brother/Printer/$PRINTER/inf/br${PRINTER}rc

	#exeinto /usr/share/brother/$PRINTER/inf
	exeinto /usr/local/Brother/Printer/$PRINTER/inf
	doexe usr/local/Brother/Printer/$PRINTER/inf/braddprinter
	doexe usr/local/Brother/Printer/$PRINTER/inf/brprintconflsr3
#	doexe braddprinter setupPrintcap
	#diropts -m 0700 -o lp -g lp
	#dodir /var/spool/lpd/${PRINTER}

}

pkg_postinst()
{
	elog "Printer connected with usb:"
	elog "  Device URI should be USB://Brother/$PRINTER"
	elog ""
	elog "Printer connected through network:"
	elog "  Printer should have the following settings:"
	elog "    Device: 'LPD/LPR Host or Printer' or 'AppSocket/HP JetDirect'"
	elog "    Device URI: 'lpd://(Your printer's ip address)/binary_p1'"
	elog "    Make/Manufacturer Selection: 'Brother'"
	elog "    Model/Driver Selection: 'Brother HL2270DW for CUPS'"
}

#pkg_prerm()
#{
#	elog "Removing ${PRINTER} from cups."
#	lpadmin -x HL2270DW
#}
