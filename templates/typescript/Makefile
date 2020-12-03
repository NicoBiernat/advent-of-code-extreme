all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app sandrokeil/typescript npx tsc -p .

run:
	docker run --rm -v $(shell pwd):/app -w /app sandrokeil/typescript node build/app.js

targetclean:
	docker run --rm -v $(shell pwd):/app -w /app sandrokeil/typescript rm -rf package-lock.json package.json node_modules build
dockerclean:
	docker image rm node

clean:
	targetclean dockerclean