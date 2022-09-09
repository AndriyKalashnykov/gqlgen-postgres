# Golang + GraphQL + Postgres (schema-first)
This repository aims to demonstrate fully end-to-end [Golang](https://golang.org/) projects.

## Running locally
```
docker-compose up
POSTGRES_USER=graphql_api POSTGRES_PASSWORD=_please_change_me_now_ POSTGRES_URL=localhost POSTGRES_DB=graphql go run server.go
```