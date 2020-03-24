# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_api,
  ecto_repos: [ElixirApi.Repo]

# Configures the endpoint
config :elixir_api, ElixirApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "j/0PqcXmCOnCAKnE5qW48ALlNTqT4HNuHQBBcR7XAKwotV3Jgb4uXetbG4nKptPl",
  render_errors: [view: ElixirApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ElixirApi.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "1+42ncuf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
