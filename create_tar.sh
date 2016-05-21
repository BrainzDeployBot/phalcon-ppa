#!/bin/bash

if [ ! -z $1 ]; then
    VERSION=$1
else
    read -p "=> Please enter the version you wish to build: " VERSION
fi

cd ..

tar -cz --exclude=.git --exclude=.gitignore --exclude=.gitmodules --exclude=debian -f php-phalcon_$VERSION.orig.tar.gz php-phalcon

cd php-phalcon
