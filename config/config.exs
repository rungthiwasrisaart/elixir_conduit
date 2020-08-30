# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :conduit,
  ecto_repos: [Conduit.Repo],
  event_stores: [Conduit.EventStore]

config :conduit, Conduit.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Conduit.EventStore
  ],
  pub_sub: :local,
  registry: :local

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: Conduit.Repo

config :vex,
  sources: [
    Conduit.Accounts.Validators,
    Conduit.Support.Validators,
    Conduit.Blog.Validators,
    Vex.Validators
  ]

# Configures the endpoint
config :conduit, ConduitWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x3XHr4Yw1jFUeSb9H9U2NI0fcL0zOiEFLBlOPxQ2m82D1gi0FmiQOzFFg1HG3X5k",
  render_errors: [view: ConduitWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Conduit.PubSub,
  live_view: [signing_salt: "oEjr6kvP"]

config :conduit, Conduit.Auth.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Conduit",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "KOVS/ciHUqw4ViRltIa0Q2ggOO8WF1jYzRHoGWh2vS2VlTdx4RHuNTCkVXYqlRd4"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
