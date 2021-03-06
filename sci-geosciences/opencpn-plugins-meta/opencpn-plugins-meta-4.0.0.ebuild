# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Meta ebuild to pull in opencpn plugins"
HOMEPAGE="https://www.gentoo.org"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	~sci-geosciences/opencpn-${PV}
	~sci-geosciences/opencpn-plugin-br24radar-1.1
	~sci-geosciences/opencpn-plugin-climatology-1.0
	~sci-geosciences/opencpn-plugin-launcher-1.0
	~sci-geosciences/opencpn-plugin-logbookkonni-1.2018
	~sci-geosciences/opencpn-plugin-objsearch-0.5.1
	~sci-geosciences/opencpn-plugin-ocpndebugger-1.0
	~sci-geosciences/opencpn-plugin-statusbar-0.5
	~sci-geosciences/opencpn-plugin-weatherfax-1.3
	~sci-geosciences/opencpn-plugin-wmm-1.0
"
