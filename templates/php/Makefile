all: compile run clean

compile:
	echo "Nothing to do, PHP is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app php php app.php

targetclean:

dockerclean:
	docker image rm php

clean:
	targetclean dockerclean