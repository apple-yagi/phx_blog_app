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
up-db:
	docker compose up -d phx_db
db-create:
	docker exec phx_web mix ecto.create
db-migrate:
	docker exec phx_web mix ecto.migrate
db-seeds:
	docker exec phx_web mix run priv/repo/seeds.exs
deps-get:
	docker compose run phx_web mix deps.get
compile:
	docker compose run phx_web mix deps.compile
npm:
	docker compose run phx_web -c "cd assets && npm i"
iex:
	docker exec phx_web iex -S mix phx.server
deps-reget:
	rm -r deps _build .elixir_ls
	@make deps-get
	@make compile
tests:
	docker compose run phx_web mix test
	docker container prune -f
phx_web:
	docker exec -it phx_web bash
phx_db:
	docker exec -it phx_db bash -c "psql -U phx"