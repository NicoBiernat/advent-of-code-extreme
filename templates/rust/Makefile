all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app rust rustc app.rs

run:
	docker run --rm -v $(shell pwd):/app -w /app rust ./app

targetclean:
	rm -f app

dockerclean:
	docker image rm rust

clean:
	targetclean dockerclean