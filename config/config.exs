# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :aht20,
  ecto_repos: [Aht20.Repo]

# Configures the endpoint
config :aht20, Aht20Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hVE+XQ3zuesj9vw9KUMO4qu9YYprUk8M8awAKadVN9iH4eoLV4oG7GkcmrFZ/d+m",
  render_errors: [view: Aht20Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Aht20.PubSub,
  live_view: [signing_salt: "PY7/GAzz"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
