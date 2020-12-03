all: compile run clean

compile:
	echo "Nothing to do, Ruby is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app ruby ruby app.rb

targetclean:

dockerclean:
	docker image rm ruby

clean:
	targetclean dockerclean