all: compile run clean

compile:
	echo "Compiling the application for day 3: "
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet dotnet publish -c release -o .

setup: # only for initial setup
	echo "Running setup for the application for day 3: "
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet dotnet new console

run:
	echo "Running the application for day 3: "
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet dotnet run

targetclean:
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet sh -c "rm -rf ./bin ./obj app.deps.json app.dll app.pdb app.runtimeconfig.json"

dockerclean:
	docker image rm microsoft/dotnet

clean:
	echo "Cleaning after the application for day 3: "
	targetclean dockerclean