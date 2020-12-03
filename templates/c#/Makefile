all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet dotnet publish -c release -o .

setup: # only for initial setup
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet dotnet new console

run:
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet dotnet run

targetclean:
	docker run --rm -v $(shell pwd):/app -w /app microsoft/dotnet sh -c "rm -rf ./bin ./obj app.deps.json app.dll app.pdb app.runtimeconfig.json"

dockerclean:
	docker image rm microsoft/dotnet

clean:
	targetclean dockerclean