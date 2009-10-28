#!/bin/bash

# cp -f srv/jetty.xml srv/jetty/etc/jetty.xml
# cp -f srv/webdefault.xml srv/jetty/etc/webdefault.xml
# (cd srv/jetty && java -jar start.jar)

java -server -jar srv/jetty-runner-7.0.0.v20091005.jar $@ src/c2

#vim:noet:ts=4:sw=4:
