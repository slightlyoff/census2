#!/bin/bash

echo "	starting Dojo build"
if [[ -d src/c2/dojo ]]
then
	echo "	clobbering old build"
	rm -rf src/c2/dojo 
	echo "	...done"
fi

./get_deps.sh

echo "done!"

#vim:noet:ts=4:sw=4:
