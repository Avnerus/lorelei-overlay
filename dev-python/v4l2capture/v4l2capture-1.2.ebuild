# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils distutils

DESCRIPTION="Python extension to capture video with video4linux2."
HOMEPAGE="http://fredrik.jemla.eu/v4l2capture"
SRC_URI="http://fredrik.jemla.eu/v4l2capture-1.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

# PYTHON_MODNAME="${MY_P/-/_}"
