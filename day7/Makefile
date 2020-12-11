all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app nimlang/nim nim c --threads:on --gc:none day7.nim

run:
	docker run --rm -v $(shell pwd):/app -w /app nimlang/nim ./day7

targetclean:
	rm -f day7

dockerclean:
	docker image rm nimlang/nim

clean:
	targetclean dockerclean