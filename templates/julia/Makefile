all: compile run clean

compile:
	echo "Nothing to do, Julia is compiled just ahead of time"
	# docker run --rm -v $(shell pwd):/app -w /app julia julia app.jl

run:
	docker run --rm -v $(shell pwd):/app -w /app julia julia app.jl

targetclean:

dockerclean:
	docker image rm julia

clean:
	targetclean dockerclean