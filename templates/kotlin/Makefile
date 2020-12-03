all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app zenika/kotlin kotlinc app.kt -include-runtime -d app.jar

run:
	docker run --rm -v $(shell pwd):/app -w /app zenika/kotlin java -jar app.jar

targetclean:
	rm -f app.jar

dockerclean:
	docker image rm zenika/kotlin

clean:
	targetclean dockerclean