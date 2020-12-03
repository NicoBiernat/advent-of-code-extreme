all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app gcc g++ -o app app.cpp

run:
	docker run --rm -v $(shell pwd):/app -w /app gcc ./app

targetclean:
	rm -f app

dockerclean:
	docker image rm gcc

clean:
	targetclean dockerclean