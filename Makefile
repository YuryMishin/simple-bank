postgres:
	docker run --name postgres-14 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14.20-trixie
createdb:
	docker exec -it postgres-14 createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres-14 dropdb --username=root --owner=root simple_bank
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
sqlc:	
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb sqlc test