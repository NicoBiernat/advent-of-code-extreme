USER := $(shell id -u)
GROUP := $(shell id -g)

all: compile dockerbuild run

# clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app gradle:jdk11-openj9 gradle -g /app/cache assemble
	sudo chown -R $(USER):$(GROUP) cache/ build/
dockerbuild:
	docker build -t kafkastreams-app:latest .

run:
	docker-compose up --abort-on-container-exit

targetclean:
	sudo rm -rf .classpath .project .settings/ .gradle/ build/ bin/ cache/

dockerclean:
	docker image rm gradle:jdk11-openj9

clean:
	targetclean dockerclean
