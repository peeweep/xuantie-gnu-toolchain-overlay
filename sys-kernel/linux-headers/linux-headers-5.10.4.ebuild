# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ETYPE="headers"
H_SUPPORTEDARCH="alpha amd64 arc arm arm64 avr32 cris frv hexagon hppa ia64 m68k metag microblaze mips mn10300 nios2 openrisc ppc ppc64 riscv s390 score sh sparc x86 xtensa"
inherit kernel-2
detect_version

PATCH_PV="5.10" # to ease testing new versions against not existing patches
PATCH_VER="1"
THEAD_COMMIT="23fdf1028b63bb52ec0900f0021617e50c1f9af0"
SRC_URI="https://github.com/T-head-Semi/xuantie-gnu-toolchain/archive/${THEAD_COMMIT}.zip -> ${P}.zip"
S="${WORKDIR}/xuantie-gnu-toolchain-${THEAD_COMMIT}/linux-headers"

KEYWORDS="~riscv"

BDEPEND="
	app-arch/unzip
	dev-lang/perl"

src_unpack() {
	# avoid kernel-2_src_unpack
	default
}

src_install() {
	mkdir -p "${ED}"$(kernel_header_destdir)
	cp -r include/* "${ED}"$(kernel_header_destdir)/

	# let other packages install some of these headers
	rm -rf "${ED}"${ddir}/scsi || die #glibc/uclibc/etc...
}
