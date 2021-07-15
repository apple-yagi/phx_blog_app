# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phx_app,
  ecto_repos: [PhxApp.Repo]

# Configures the endpoint
config :phx_app, PhxAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dlpvzV0p9Erxgu0mIBXuFu0cyLHlrOydv/T3+F9K769fwFqBF3fPnkOAjekOe/WO",
  render_errors: [view: PhxAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PhxApp.PubSub,
  live_view: [signing_salt: "jIjMtTz+"]

config :phx_app, PhxApp.Auth.Guardian,
  # optional
  allowed_algos: ["HS512"],
  # optional
  verify_module: Guardian.JWT,
  issuer: "PhxApp",
  ttl: {30, :days},
  allowed_drift: 2000,
  # optional
  verify_issuer: true,
  secret_key: System.get_env("GUARDIAN_KEY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
