all: compile run clean

compile:
	docker pull elixir
	echo "Compiling the application for day 2: "
	docker run --rm -v $(shell pwd):/app -w /app elixir /usr/local/bin/elixirc day2.ex

run:
	docker pull elixir
	echo "Running the application for day 2: "
	docker run --rm -v $(shell pwd):/app -w /app elixir elixir day2.exs

targetclean:
	rm -f Elixir.Day2.beam

dockerclean:
	docker image rm elixir

clean:
	echo "Cleaning after the application for day 1: "
	targetclean dockerclean