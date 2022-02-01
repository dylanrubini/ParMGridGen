#!/bin/bash

rm -r build 

mkdir build
rm -r lib

mkdir lib
cd build

make clean

INSTALL_PATH="-DCMAKE_INSTALL_PREFIX="${UTBLOCK_DIR}/third-party/ParMGridGen/FortInterface/lib/""
MGRID_LIB="-DMGRIDGEN_LIB="${UTBLOCK_DIR}/third-party/ParMGridGen/libmgrid.a"" 

if [[ $OP2_F_COMPILER == 'gnu' ]]; then
	FC=gfortran   cmake .. $MGRID_LIB $INSTALL_PATH -DINT=32 -DREAL=64
elif [[ $OP2_F_COMPILER == 'intel'  ]]; then
	FC=ifort     cmake ..  $MGRID_LIB $INSTALL_PATH  -DINT=32 -DREAL=64
elif [[ $OP2_F_COMPILER == 'nvhpc'  ]]; then
	FC=nvfortran cmake ..  $MGRID_LIB $INSTALL_PATH  -DINT=32 -DREAL=64
elif [[ $OP2_F_COMPILER == 'pgi'  ]]; then
	FC=pgfortran cmake ..  $MGRID_LIB $INSTALL_PATH  -DINT=32 -DREAL=64	
fi

if [[ $? -eq 0 ]]; then 
	make install
	cd ..
else 
    cd ..	
	(exit 33) 	
fi

rm -r build/