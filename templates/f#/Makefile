all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app fsharp fsharpc app.fs

setup:
	docker run --rm -v $(shell pwd):/app -w /app fsharp dotnet new console -lang "F#"

run:
	docker run --rm -v $(shell pwd):/app -w /app fsharp mono app.exe

targetclean:
	rm -f app.exe FSharp.Core.dll

dockerclean:
	docker image rm fsharp

clean:
	targetclean dockerclean