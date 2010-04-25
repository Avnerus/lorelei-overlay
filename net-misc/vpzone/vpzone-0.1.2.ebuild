# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="A flexible, IPv6 layer 3 VPN daemon"
HOMEPAGE="http://www.vpzone.org/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${P}.tar.bz2"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND="=dev-libs/libevent-1.4*
		>=net-dns/c-ares-1.4
		net-misc/babeld
		net-libs/gnutls"

src_configure() {

	econf $(use_enable debug) --prefix=/usr || die "Configure failed"

}

src_compile() {

	emake || die "Make all failed"

}

src_install() {

	emake DESTDIR="${D}" install || die "Make install failed"

	find "${D}" -name '*.la' -delete

	dodoc Changelog README || die "dodoc failed"

	doman doc/${PN}.8 || die "doman failed"
	doman doc/${PN}.conf.8 || die "doman failed"

	# Empty dir
	dodir /etc/vpzone
	keepdir /etc/vpzone

	# Install the init script 
	newinitd "${FILESDIR}/${PN}.init" vpzone

}

pkg_postinst() {
	einfo "The vpzone init script expects to find the configuration file"
	einfo "vpzone.conf in /etc/vpzone along with any extra files it may need."
	einfo ""
	einfo "To create more VPNs, simply create a new .conf file for it and"
	einfo "then create a symlink to the vpzone init script from a link called"
	einfo "vpzone.newconfname - like so"
	einfo "   cd /etc/vpzone"
	einfo "   ${EDITOR##*/} foo.conf"
	einfo "   cd /etc/init.d"
	einfo "   ln -s vpzone vpzone.foo"
	einfo ""
	einfo "You can then treat vpzone.foo as any other service, so you can"
	einfo "stop one vpn and start another if you need to."
}


