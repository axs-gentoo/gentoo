# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="http://qpdf.sourceforge.net/"
SRC_URI="mirror://sourceforge/qpdf/${P}.tar.gz"

LICENSE="Artistic-2"

# subslot = libqpdf soname version
SLOT="0/17"

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~m68k-mint ~sparc-solaris"
IUSE="doc examples perl static-libs test"

CDEPEND="
	dev-libs/libpcre
	sys-libs/zlib
"
DEPEND="${CDEPEND}
	test? (
		sys-apps/diffutils
		media-libs/tiff
		app-text/ghostscript-gpl[tiff]
	)
"
# Only need perl for the installed tools.
RDEPEND="${CDEPEND}
	perl? ( >=dev-lang/perl-5.8 )
"

DOCS=( ChangeLog README TODO )

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable test test-compare-images)
}

src_install() {
	default

	if ! use perl ; then
		rm "${ED}"/usr/bin/fix-qdf || die
		rm "${ED}"/usr/share/man/man1/fix-qdf.1 || die
	fi

	if use examples ; then
		dobin examples/build/.libs/*
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}
