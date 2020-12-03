all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app cyberdojofoundation/freepascal fpc /app/app.pas

run:
	docker run --rm -v $(shell pwd):/app -w /app cyberdojofoundation/freepascal ./app

targetclean:
	rm -f app.o
	rm -f app

dockerclean:
	docker image rm cyberdojofoundation/freepascal

clean: 
	targetclean dockerclean