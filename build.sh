#!/bin/bash

set -e

make clean
make realclean

if [[ $? -eq 0 ]]; then 
	make  
else 
    cd ..	
	(exit 33) 	
fi

if [[ $? -eq 0 ]]; then 
	make parallel
else 
    cd ..	
	(exit 33) 	
fi


if [[ $? -eq 0 ]]; then 
	cd FortInterface

	./build.sh

	cd .. 
else 
    cd ..	
	(exit 33) 	
fi
