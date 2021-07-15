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
restart:
	docker compose down
	docker compose up -d
db-create:
	docker exec phx_web mix ecto.create
db-migrate:
	docker exec phx_web mix ecto.migrate
deps-get:
	docker exec phx_web mix deps.get
iex:
	docker exec phx_web iex -S mix phx.server
phx_web:
	docker exec -it phx_web bash
phx_db:
	docker exec -it phx_db bash -c "psql -U phx"