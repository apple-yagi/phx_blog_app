build:
	docker compose build
up:
	docker compose up -d
down:
	docker compose down
db-create:
	docker exec phx_web mix ecto.create
iex:
	docker exec phx_web iex -S mix phx.server