all: compile run clean

compile:
	echo "Compiling the application for day 2: "
	docker pull elixir
	docker run --rm -v $(shell pwd):/app elixir /usr/local/bin/elixirc /app/day2.ex -o /app

run:
	echo "Running the application for day 2: "
	docker pull elixir
	docker run --rm -v $(shell pwd):/app elixir bash -c "cd /app && elixir day2.exs"

targetclean:
	rm -f Elixir.Day2.beam

dockerclean:
	docker image rm elixir

clean:
	echo "Cleaning after the application for day 1: "
	targetclean dockerclean