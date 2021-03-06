# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1
#distutils-r1

DESCRIPTION="Open Source framework for automation"
HOMEPAGE="http://www.beremiz.org/"

if [[ ${PV} == "9999" ]] ; then
	inherit mercurial
	EHG_REPO_URI_BASE="http://dev.automforge.net/"
	EHG_REPO_URI="${EHG_REPO_URI_BASE}/${PN}"
	KEYWORDS="~amd64 ~x86"
else
	inherit vcs-snapshot
	SRC_URI="
	   http://dev.automforge.net/${PN}/archive/tip.tar.bz2 -> ${P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="canfestival doc +twisted"

RDEPEND="
		canfestival? ( dev-libs/canfestival
		               dev-python/gnosis-utils )
		twisted? ( dev-python/twisted-core
		           dev-python/autobahn  )
		dev-lang/matiec
        dev-python/wxpython:2.8
		dev-python/nevow
        dev-python/numpy
    	dev-python/pyro:3
		dev-python/lxml
		dev-util/wxglade"

DEPEND="${RDEPEND}
	doc? (
		dev-python/sphinx
		dev-python/sphinx-better-theme
	)"

src_prepare() {
    epatch "${FILESDIR}/beremiz-fix-path.patch"
    epatch "${FILESDIR}/beremiz-fix-pyro.patch"
    #EPATCH_OPTS="-p1" epatch "${FILESDIR}/beremiz-add-setuptools.patch"
    #cp "${FILESDIR}/setup.py" ${S}
}

src_install() {
	insinto /usr/share/${PN}
	doins -r * || die "Install failed!"
 	
    #insinto /usr/share/applications
	#doins debian/{beremiz{_doc,_svgui,_wxglade},beremiz}.desktop
 
	fperms 0755 /usr/share/"${PN}"/Beremiz.py
	dosym /usr/share/"${PN}"/Beremiz.py /usr/bin/beremiz
 	#python_foreach_impl python_doexe Beremiz.py ${PN}
 	
	# Install icon and desktop file
	newicon "images/brz.png" "${PN}.png"
    make_desktop_entry "${PN}" "${PN}" "${PN}" "Development"
 
#	if use doc; then
#		docinto doc
#		dodoc doc/{index.rst,overview.rst,standards.rst}
#		docinto manual
#		dodoc doc/manual/{build.rst,debug.rst,edit.rst,index.rst,install.rst,start.rst}
#		#dohtml -r doc/*
#	fi
}