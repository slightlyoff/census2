# Introduction #

The census2 benchmark is explicitly designed to be simple to get up-and-running on Unix-like systems or Windows under Cygwin.

# Dependencies #

To run the benchmarks, you'll need a working BASH (or compatible) shell, Java 1.5 or better, and wget or cURL installed in your PATH. On most Unix-like systems, this is likely to Just Work (TM), although on Linux and under Cygwin you may want to make sure that Java is installed correctly. All other dependencies, including compilers, web servers, and the like are fetched as a part of the bootstrapping process.

# Quick Start #

To get started from a release, download the latest release tarball from the Google Code site (FIXME: link!) and expand it on your filesystem. For example:

```
%> cd parentDir
%> wget http://census2.googlecode.com/files/census2_0.0.1_snapshot.tar.gz
%> tar -zxvf census2.tar.gz
...
%> cd census2
```

Or, if you'd like to keep up-to-date with the project, ensure that you have the a Subversion client installed correctly on your system and do the following:

```
%> cd parentDir
%> svn co http://census2.googlecode.com/svn/trunk/ census2
...
%> cd census2
```

In either case, you should now be inside the `census2` directory. Now type:

```
%> ./get_deps.sh
...
```

This kicks off a process that fetches Dojo, Flex, and other dependencies not included in the distribution and performs the necessary build steps to make sure that the test harness will load and that the tests will run.

**Note:** some of the files fetched by this process may be quite large (> 50MB) and that the build steps may consume many system resources and, depending on your system, may be time consuming. We apologize in advance for the inconvenience.

Once this process completes the tests are ready to run!

To start the included web server and run the tests, type:

```
%> ./run_census.sh
2008-12-05 08:50:34.069::INFO:  Logging to STDERR via org.mortbay.log.StdErrLog
...
```

To kill the test sever, just press "Ctrl-C". Once the test server is started, point your browser at `http://localhost:8080/census.html`.

No init scripts or daemonization is provided as a part of this package yet. If you'd like these features for your OS, please file a ticket or provide a patch.

# Server Options #

The included web server is Jetty Runner from the Jetty project and `run_census.sh` simply calls out to it with a particular directory (`src/c2`) as the root to serve. To see what options are available for changing the server, say, to run it on a different port, simply run the jetty-runner JAR without any options, like this:

```
%> java -jar srv/jetty-runner-7.0.0.pre5.jar 
2008-12-05 08:54:25.380::INFO:  Logging to STDERR via org.mortbay.log.StdErrLog
2008-12-05 08:54:25.383::INFO:  Runner
ERROR: No Contexts defined
Usage: java [-DDEBUG] [-Djetty.home=dir] -jar jetty-runner.jar [--help|--version] [ server opts] [[ context opts] context ...] 
Server Options:
 --log file                         - request log filename (with optional 'yyyy_mm_dd' wildcard
 --out file                         - info/warn/debug log filename (with optional 'yyyy_mm_dd' wildcard
 --port n                           - port to listen on (default 8080)
 --jar file                         - a jar to be added to the classloader
--jdbc classname properties jndiname - classname of XADataSource or driver; properties string; name to register in jndi
 --lib dir                          - a directory of jars to be added to the classloader
 --classes dir                      - a directory of classes to be added to the classloader
 --txFile                           - override properties file for Atomikos
 --stats [unsecure|realm.properties] - enable stats gathering servlet context
 --config file                      - a jetty xml config file to use instead of command line options
Context Options:
 --path /path       - context path (default /)
 context            - WAR file, web app dir or context.xml file
```

`run_census.sh` respects options passed in, so to run the tests on a different port, just call:

```
%> ./run_census.sh --port 80
```