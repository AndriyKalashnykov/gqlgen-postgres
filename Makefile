GOFLAGS=-mod=mod

clean:
	@rm -rf ./.bin/
	@sudo rm -rf vendor/
	@mkdir ./.bin/

docker-up: docker-down
	docker-compose -f "docker-compose.yml" up

docker-down:
	docker-compose -f "docker-compose.yml" down --volumes

generate: clean
	@sudo rm -rf graph/model
	@sudo rm -rf graph/generated
	@export GO15VENDOREXPERIMENT=0; export GOFLAGS=$(GOFLAGS); go run github.com/99designs/gqlgen generate --verbose

test: generate
	@export GOFLAGS=$(GOFLAGS); go test -v ./...

run:
	@export PORT=5432; export POSTGRES_USER=graphql_api; export POSTGRES_PASSWORD=_please_change_me_now_; export POSTGRES_URL=localhost; export POSTGRES_DB=graphql; go run server.go

build:
	@export GOFLAGS=$(GOFLAGS); go build -o ./.bin/server server.go

image: generate
	docker build -t gqlgen-postgres .

get: clean
	@export GOFLAGS=$(GOFLAGS); go get .

deps:
	@export GOFLAGS=$(GOFLAGS); go install github.com/99designs/gqlgen@latest

upgrade: clean
	@export GOFLAGS=$(GOFLAGS); go get -u
	@export GOFLAGS=$(GOFLAGS); go mod tidy
