all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app gcc gcc -o app app.c

run:
	docker run --rm -v $(shell pwd):/app -w /app gcc ./app

targetclean:
	rm -f app

dockerclean:
	docker image rm gcc

clean:
	targetclean dockerclean