all: compile run clean

compile:
	echo "Nothing to do, Dart is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app google/dart dart app.dart

targetclean:

dockerclean:
	docker image rm google/dart

clean:
	targetclean dockerclean