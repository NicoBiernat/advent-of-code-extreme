all: compile run clean

compile:
	docker run --rm -v $(shell pwd):/app -w /app mborges/fortran gfortran app.f90 -o app

run:
	docker run --rm -v $(shell pwd):/app -w /app mborges/fortran ./app

targetclean:
	rm -f app

dockerclean:
	docker image rm mborges/fortran

clean:
	targetclean dockerclean