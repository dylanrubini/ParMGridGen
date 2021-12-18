#!/bin/bash

set -e

make clean
make realclean

if [[ $? -eq 0 ]]; then 
	make  
else 
	return 	
fi

if [[ $? -eq 0 ]]; then 
	make parallel
else 
	return 	
fi


if [[ $? -eq 0 ]]; then 
	cd FortInterface

	./build.sh

	cd .. 
else 
	return 	
fi
