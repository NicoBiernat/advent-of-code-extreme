all: compile run clean

compile:
	echo "Nothing to do, JavaScript is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app node node app.js

targetclean:

dockerclean:
	docker image rm node

clean:
	targetclean dockerclean