all: compile run clean

compile:
	echo "Compiling the application for day 2: "
	docker run --rm -v $(shell pwd):/app -w /app elixir /usr/local/bin/elixirc day2.ex

run:
	echo "Running the application for day 2: "
	docker run --rm -v $(shell pwd):/app -w /app elixir elixir day2.exs

targetclean:
	rm -f Elixir.Day2.beam

dockerclean:
	docker image rm elixir

clean:
	echo "Cleaning after the application for day 2: "
	targetclean dockerclean