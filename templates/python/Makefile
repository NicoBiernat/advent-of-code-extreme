all: compile run clean

compile:
	echo "Nothing to do, Python is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app python python app.py

targetclean:

dockerclean:
	docker image rm python

clean:
	targetclean dockerclean