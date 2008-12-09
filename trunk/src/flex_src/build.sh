#!/bin/bash


# <macrodef name="compileflex">
#   <attribute name="src"/>
#   <attribute name="dest"/>
#   <attribute name="app"/>
#   <element name="uptodatefiles" optional="true"/>
#   <sequential>
#     <uptodate property="@{src}.uptodate" targetfile="@{dest}">
#       <srcfiles file="@{src}"/>
#       <srcfiles file="build/base.swc"/>
#       <srcfiles file="${src.flex.dir}/flex.css"/>
#       <srcfiles dir="build/@{app}.war/WEB-INF/flex" includes="*.xml"/>
#       <uptodatefiles/>
#     </uptodate>
#     <antcall target="compilemxml">
#       <param name="src" value="@{src}"/>
#       <param name="dest" value="@{dest}"/>
#       <param name="app" value="@{app}"/>
#     </antcall>
#   </sequential>
# </macrodef>
#
# <target name="compilemxml" unless="${src}.uptodate">
#   <java jar="${flex.sdk.dir}/lib/mxmlc.jar" fork="true" maxmemory="128m">
#     <jvmarg value="-Dapplication.home=${flex.sdk.dir}"/>
#     <!--<arg value="+flexlib=build/census.war/WEB-INF/flex"/>-->
#     <arg value="-external-library-path+=build/base.swc"/>
#     <arg value="-library-path+=lib/rpc-189826.swc"/>
#     <arg value="-runtime-shared-libraries=base.swf"/>
#     <arg value="-licenses.license" />
#     <arg value="flexbuilder3"/>
#     <arg value="${flexbuilder3}"/>
#     <arg value="-compiler.services" />
#     <arg value="build/${app}.war/WEB-INF/flex/services-config.xml" />
#     <arg value="-compiler.context-root" />
#     <arg value="/${app}" />
#     <arg value="-file-specs" />
#     <arg value="${src}" />
#     <arg value="-output" />
#     <arg value="${dest}" />
#   </java>  
# </target>

FLEX_SDK_DIR=../flex_sdk

function compileMxml {
	echo $1
	echo $2
	if [[ ! -d $FLEX_SDK_DIR ]]; then
		echo "ERROR: No Flex SDK found! Plese re-run get_deps.sh from the root project directory"
		exit
	fi
	#	-debug=true \
	java -Dapplication.home=$FLEX_SDK_DIR -jar $FLEX_SDK_DIR/lib/mxmlc.jar \
		-library-path+=as3corelib.swc \
		-compiler.context-root ../src \
		-file-specs $1 \
		-output $2
}

compileMxml "flex_json.mxml" "../c2/resources/flex/flex_json.swf"
compileMxml "flex_xml_as.mxml" "../c2/resources/flex/flex_xml_as.swf"
compileMxml "flex_xml_e4x.mxml" "../c2/resources/flex/flex_xml_e4x.swf"
compileMxml "flex_soap_as.mxml" "../c2/resources/flex/flex_soap_as.swf"

#
#   <compileflex src="${src.flex.dir}/flex_xml_as.mxml" dest="build/census.war/flex_xml_as.swf" app="census"/>
#
#   <compileflex src="${src.flex.dir}/flex_xml_e4x.mxml" dest="build/census.war/flex_xml_e4x.swf" app="census"/>
