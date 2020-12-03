all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app mozilla/sbt sbt compile

run:
	docker run --rm -v $(shell pwd):/app -w /app mozilla/sbt sbt run

targetclean:
	docker run --rm -v $(shell pwd):/app -w /app mozilla/sbt rm -rf .bsp project target

dockerclean:
	docker image rm mozilla/sbt

clean:
	targetclean dockerclean