#!/bin/bash

FLEX_OUT_DIR=`pwd`/src/c2/rsources/flex
echo $FLEX_OUT_DIR

echo "	starting Flex build"
if [[ -d $FLEX_OUT_DIR ]]
then
	echo "		clobbering old Flex"
	rm -rf $FLEX_OUT_DIR  
	echo "		...done"
fi

./get_deps.sh

echo "	done!"

#vim:noet:ts=4:sw=4:
