all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app swift swiftc -g app.swift

run:
	docker run --rm -v $(shell pwd):/app -w /app swift ./app

targetclean:
	echo "TODO"

dockerclean:
	docker image rm swift

clean:
	targetclean dockerclean