all: compile run clean

compile:
	echo "Compiling the application for day 4: "
	echo "Nothing to do, Ruby is an interpreted language"

run:
	echo "Running the application for day 4: "
	docker run --rm -v $(shell pwd):/app -w /app ruby ruby day4.rb

targetclean:

dockerclean:
	docker image rm ruby

clean:
	echo "Cleaning after the application for day 4: "
	targetclean dockerclean