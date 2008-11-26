This is v2 of the Census RIA data loading benchmarking application. Java 1.5 or
better is required. A web server is included in the distribution of the
benchmark and no database is required.

Some of the dependencies of the benchmark are not included in the distribution.
The "get_deps.sh" shell script is provided to fetch the correct versions of
Flex, Dojo, and other tested frameworks. Please run it first.

Once the dependencies have been satisfied, you can build the tests by running:

	$> ./make_census.sh
	$> ./run_census.sh

and then navigate to:

	http://localhost:8080/c2/census.html

See HACKING.txt for notes on how to extend the test suite and join the Census 2
open source project.
