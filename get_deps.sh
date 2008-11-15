#!/bin/bash

DOJO_VERSION=1.2.1
FLEX_VERSION=3.1.0.2710
FLEX_SDK_NAME="flex_sdk_"$FLEX_VERSION"_mpl.zip"

# export _JAVA_OPTIONS="-Xms512m -Xmx1g"

echo "setting up dependencies"

if [[ ! -d src/flex_sdk ]]
then
	cd src
	echo "	downloading the Open Source Flex SDK..."
	mkdir flex_sdk
	cd flex_sdk
	wget "http://flexorg.wip3.adobe.com/flexsdk/$FLEX_VERSION/$FLEX_SDK_NAME"
	unzip $FLEX_SDK_NAME
	rm $FLEX_SDK_NAME
	cd ..
	echo "	...done"
	cd ..
fi


if [[ ! -d src/c2/dojo ]]
then
	cd src
	if [[ ! -d dojo_src ]]
	then
		echo "	downloading Dojo..."
		wget http://download.dojotoolkit.org/release-$DOJO_VERSION/dojo-release-$DOJO_VERSION-src.zip
		unzip dojo-release-$DOJO_VERSION-src.zip
		mv dojo-release-$DOJO_VERSION-src dojo_src
		rm dojo-release-$DOJO_VERSION-src.zip
		echo "	...done"

	fi

	echo "	copying in updated Dojo Charting..."
	rm -rf dojo_src/dojox/charting
	rm -rf dojo_src/dojox/gfx
	cp -r dojo_patches/charting dojo_src/dojox/
	cp -r dojo_patches/gfx dojo_src/dojox/
	echo "	...done"

	echo "	creating Dojo build against custom layer"

	cd dojo_src/util/buildscripts

	echo "" > copyright_mini.txt

	_JAVA_OPTIONS="-Xms512m -Xmx1g" ./build_mini.sh action=clean,release profileFile=../../../census.profile.js
	echo "	...done"

	echo "	moving Dojo build into place"

	mv  ../../release/dojo ../../../c2/dojo

	cd ../../../

	echo "	...done"

	# FIXME: should we delete the dojo src dir?

	cd ..
fi
