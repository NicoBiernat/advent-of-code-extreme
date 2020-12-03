all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app openjdk javac app.java

run:
	docker run --rm -v $(shell pwd):/app -w /app openjdk java app

targetclean:
	rm -f app.class

dockerclean:
	docker image rm openjdk

clean:
	targetclean dockerclean