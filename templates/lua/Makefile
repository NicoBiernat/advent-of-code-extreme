all: compile run clean

compile:
	echo "Nothing to do, Lua is an interpreted language"

run:
	docker run --rm -v $(shell pwd):/app -w /app woahbase/alpine-lua lua app.lua

targetclean:

dockerclean:
	docker image rm woahbase/alpine-lua

clean:
	targetclean dockerclean