# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :conduit,
  ecto_repos: [Conduit.Repo]

config :conduit,
  event_stores: [Conduit.EventStore]


# Configures the endpoint
config :conduit, ConduitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x3XHr4Yw1jFUeSb9H9U2NI0fcL0zOiEFLBlOPxQ2m82D1gi0FmiQOzFFg1HG3X5k",
  render_errors: [view: ConduitWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Conduit.PubSub,
  live_view: [signing_salt: "oEjr6kvP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
