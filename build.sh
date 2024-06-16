#!/usr/bin/env bash

cd linux-6.7/
cp ../config .config
scripts/config --disable DEBUG_INFO
scripts/config --disable SYSTEM_TRUSTED_KEYS
scripts/config --disable SYSTEM_REVOCATION_KEYS
patch -Np1 < ../cjktty/cjktty-6.7.patch
make -j$(nproc) CONFIG_FILE=../config
make modules
mkdir ../done
cp ./* ../done/
cd ..
tar zcf kernel.tar.gz done/
mv kernel.tar.gz artifact/