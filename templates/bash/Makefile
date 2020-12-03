all: compile run clean

compile:
	echo "Nothing to do, Bash is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app bash bash app.sh

targetclean:

dockerclean:
	docker image rm bash

clean:
	targetclean dockerclean