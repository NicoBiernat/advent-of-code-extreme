all: compile run clean

compile:
	echo "Compiling the application for day 1: "
	docker pull cyberdojofoundation/freepascal
	docker run --rm -v $(shell pwd):/app cyberdojofoundation/freepascal fpc /app/day1.pas

run:
	echo "Running the application for day 1: "
	docker pull cyberdojofoundation/freepascal
	docker run --rm -v $(shell pwd):/app cyberdojofoundation/freepascal bash -c "cd /app" && ./day1

targetclean:
	rm -f day1.o
	rm -f day1

dockerclean:
	docker image rm cyberdojofoundation/freepascal

clean: 
	echo "Cleaning after the application for day 1: "
	targetclean dockerclean