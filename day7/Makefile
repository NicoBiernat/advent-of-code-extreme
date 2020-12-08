all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app nimlang/nim nim c --threads:on --gc:none app.nim

run:
	docker run --rm -v $(shell pwd):/app -w /app nimlang/nim ./app

targetclean:
	rm -f app

dockerclean:
	docker image rm nimlang/nim

clean:
	targetclean dockerclean