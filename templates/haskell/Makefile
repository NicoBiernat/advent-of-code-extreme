all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app haskell ghc -o app app.hs

run:
	docker run --rm -v $(shell pwd):/app -w /app haskell ./app

targetclean:
	rm -f app.hi app.o app

dockerclean:
	docker image rm haskell

clean:
	targetclean dockerclean