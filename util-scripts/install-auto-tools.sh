#!/usr/bin/env bash
set -e

if [[ -z "$1" ]]; then
   echo "provide PREFIX as positional argument"
   exit 1
fi

PREFIX=$(readlink -f $1)

if ! [[ -d "$PREFIX" ]]; then
	mkdir -p $PREFIX
else
	echo "$PREFIX already exists"
fi

export PATH="$PREFIX/bin:$PATH"

download_and_unpack() {
   wget $1
   mkdir -p out
   tar -xvf *.tar.xz --strip 1 -C out
   rm *.tar.xz
   cd out
   ./configure --prefix="$PREFIX"
   make -j $(nproc)
   make install
   cd ..
   rm -rf out
}

download_and_unpack https://ftp.gnu.org/gnu/m4/m4-latest.tar.xz
download_and_unpack https://ftp.gnu.org/gnu/autoconf/autoconf-latest.tar.xz
download_and_unpack https://ftp.gnu.org/gnu/automake/automake-1.17.tar.xz
download_and_unpack https://ftp.gnu.org/gnu/libtool/libtool-2.5.4.tar.xz

echo "finished 🚀"
echo ""
echo "Add $PREFIX to PATH env"

