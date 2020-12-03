all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app erlang erlc app.erl

run:
	docker run --rm -v $(shell pwd):/app -w /app erlang erl -noshell -run app main -run init stop

targetclean:
	rm -f app.beam
	rm -f *.dump

dockerclean:
	docker image rm erlang

clean:
	targetclean dockerclean