#!/bin/bash

set -e

make clean
make realclean

make

make parallel

cd FortInterface

./build.sh

cd ..
