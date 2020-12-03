all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app golang go build

run:
	docker run --rm -v $(shell pwd):/app -w /app golang ./app

targetclean:
	rm -f app

dockerclean:
	docker image rm golang

clean:
	targetclean dockerclean