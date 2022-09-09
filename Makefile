GOFLAGS="-mod=mod"

clean:
	@rm -rf ./.bin/
	@sudo rm -rf vendor/
	@mkdir ./.bin/

generate: clean
	@sudo rm -rf graph/model
	@sudo rm -rf graph/generated
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go run github.com/99designs/gqlgen generate

test: generate
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go test -v ./...

run:
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go run server.go

build:
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go build -o ./.bin/server server.go

image: generate
	docker build -t gqlgen-postgres .

get: clean
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go get .

deps:
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go install github.com/99designs/gqlgen@latest

upgrade: clean
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go get -u
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go mod tidy
