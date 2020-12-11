all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app gcc gcc -o day10 day10.c

run:
	docker run --rm -v $(shell pwd):/app -w /app gcc ./day10

targetclean:
	rm -f day10

dockerclean:
	docker image rm gcc

clean:
	targetclean dockerclean