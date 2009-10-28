#!/bin/bash

DOJO_VERSION=1.4.0b2
FLEX_VERSION=3.3.0.4589
FLEX_SDK_NAME="flex_sdk_"$FLEX_VERSION"_mpl.zip"
FLEX_OUT_DIR=`pwd`/src/c2/resources/flex

# export _JAVA_OPTIONS="-Xms512m -Xmx1g"

function getFile {
	echo $1
	if [[ -x `which wget` ]]; then
		wget $1
	else
		if [[ -x `which curl` ]]; then
			curl -O $1
		fi
	fi
}

echo "setting up dependencies"

if [[ ! -d src/flex_sdk ]]
then
	cd src
	echo "	downloading the Open Source Flex SDK..."
	mkdir flex_sdk
	cd flex_sdk
	getFile "http://flexorg.wip3.adobe.com/flexsdk/$FLEX_VERSION/$FLEX_SDK_NAME"
	unzip $FLEX_SDK_NAME
	rm $FLEX_SDK_NAME
	cd ..
	echo "	...done"
	cd ..
fi

if [[ ! -d $FLEX_OUT_DIR ]]
then
	mkdir -p $FLEX_OUT_DIR
	LWD=`pwd`
	cd src/flex_src
	./build.sh
	cd $LWD
fi

if [[ ! -d src/c2/dojo ]]
then
	cd src
	if [[ ! -d dojo_src ]]
	then
		echo "	downloading Dojo..."
		getFile http://download.dojotoolkit.org/release-$DOJO_VERSION/dojo-release-$DOJO_VERSION-src.zip
		unzip dojo-release-$DOJO_VERSION-src.zip
		mv dojo-release-$DOJO_VERSION-src dojo_src
		rm dojo-release-$DOJO_VERSION-src.zip
		echo "	...done"

	fi

	# echo "	copying in updated Dojo Charting..."		
	# rm -rf dojo_src/dojox/charting		
	# cp -r dojo_patches/charting dojo_src/dojox/	
	# echo "	...done"		

	echo "	creating Dojo build against custom layer"

	cd dojo_src/util/buildscripts

	echo "" > copyright_mini.txt

	_JAVA_OPTIONS="-Xms512m -Xmx1g" ./build.sh mini=true cssOptimize=comments expandProvide=true action=clean,release profileFile=../../../census.profile.js
	echo "	...done"

	echo "	moving Dojo build into place"

	mv  ../../release/dojo ../../../c2/dojo

	cd ../../../

	echo "	...done"

	# FIXME: should we delete the dojo src dir?

	cd ..
fi

echo "done!"

#vim:noet:ts=4:sw=4:
