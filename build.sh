#!/usr/bin/env bash
set -e

version=$1
src_dir=$PWD/src
target_dir=$PWD/target

mkdir $src_dir
mkdir $target_dir

cd $src_dir

curl -O https://ftp.postgresql.org/pub/source/v$version/postgresql-$version.tar.bz2
curl -sS https://ftp.postgresql.org/pub/source/v$version/postgresql-$version.tar.bz2.sha256 | shasum -c
tar xjf postgresql-$version.tar.bz2

export LDFLAGS="-L $(brew --prefix openssl)/lib"
export CPPFLAGS="-I $(brew --prefix openssl)/include"

cd postgresql-$version

./configure --prefix=$target_dir \
            --disable-debug \
            --enable-thread-safety \
            --with-bonjour \
            --with-gssapi \
            --with-ldap \
            --with-openssl \
            --with-pam \
            --with-libxml \
            --with-libxslt \
            --without-readline

cd src/interfaces/libpq
make
make install
cd -

cd src/backend
make ../../src/include/utils/errcodes.h
make ../../src/include/utils/fmgroids.h
cd -

cd src/include
make install
cd -
