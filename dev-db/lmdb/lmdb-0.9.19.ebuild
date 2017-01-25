# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit toolchain-funcs flag-o-matic

DESCRIPTION="An ultra-fast, ultra-compact key-value embedded data store"
HOMEPAGE="http://symas.com/mdb/"
SRC_URI="https://github.com/LMDB/lmdb/archive/LMDB_${PV}.tar.gz"

LICENSE="OPENLDAP"
SLOT="0/${PV}"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="static-libs"

DEPEND=""
# =net-nds/openldap-2.4.40 installs lmdb files.
RDEPEND="!=net-nds/openldap-2.4.40"

S="${WORKDIR}/${PN}-LMDB_${PV}/libraries/liblmdb"

src_prepare() {
	sed -i -e "s!^CC.*!CC = $(tc-getCC)!" \
		-e "s!^CFLAGS.*!CFLAGS = ${CFLAGS}!" \
		-e "s!^AR.*!AR = $(tc-getAR)!" \
		-e "/^prefix/s!/usr/local!${EPREFIX}/usr!" \
		-e "/^libdir/s!lib\$!$(get_libdir)!" \
		-e "s!shared!shared -Wl,-soname,liblmdb.so.0!" \
		"${S}/Makefile" || die
	eapply_user
}

src_configure() {
	if [[ ${CHOST} == *-solaris* ]] ; then
		# ensure sigwait has a second sig argument
		append-cppflags -D_POSIX_PTHREAD_SEMANTICS
	fi
}

src_compile() {
	emake LDLIBS+=" -pthread"
}

src_install() {
	emake DESTDIR="${D}" install

	mv "${ED}"usr/$(get_libdir)/liblmdb.so{,.0} || die
	dosym liblmdb.so.0 /usr/$(get_libdir)/liblmdb.so

	use static-libs || rm "${ED}"usr/$(get_libdir)/liblmdb.a || die
}