use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :conduit, Conduit.Repo,
  username: "postgres",
  password: "mysecretpassword",
  database: "conduit_readstore_test",
  hostname: "localhost",
  pool_size: 1

# Configure your eventstore
config :conduit, Conduit.EventStore,
  serializer: EventStore.JsonSerializer,
  username: "postgres",
  password: "mysecretpassword",
  database: "conduit_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conduit, ConduitWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
