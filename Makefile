init:
	@make build
	@make up
	@make db-create
build:
	docker compose build
up:
	docker compose up -d
down:
	docker compose down
db-create:
	docker exec phx_web mix ecto.create
db-migrate:
	docker exec phx_web mix ecto.migrate
iex:
	docker exec phx_web iex -S mix phx.server