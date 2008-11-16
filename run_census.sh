#!/bin/bash

# cp -f srv/jetty.xml srv/jetty/etc/jetty.xml
# cp -f srv/webdefault.xml srv/jetty/etc/webdefault.xml
# (cd srv/jetty && java -jar start.jar)

java -server -jar srv/jetty-runner-7.0.0.pre5.jar $@ src/c2
