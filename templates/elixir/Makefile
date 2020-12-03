all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app elixir /usr/local/bin/elixirc app.ex

run:
	docker run --rm -v $(shell pwd):/app -w /app elixir elixir app.exs

targetclean:
	rm -f *.beam *.dump

dockerclean:
	docker image rm elixir

clean:
	targetclean dockerclean