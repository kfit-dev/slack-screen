# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
#config :starter_app,
#  ecto_repos: [StarterApp.Repo]

# Configures the endpoint
config :starter_app, StarterApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EfFEsRFa7/zuQMxlvTAXKggPOo3MxVXBoI2wkP9r98QvvTEN0LEexKFqL/9x8Jwk",
  render_errors: [view: StarterApp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: StarterApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :starter_app, StarterApp.Repo,
  adapter: Sqlite.Ecto,
  database: "starter_app.sqlite3"
