use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :scrawley, Scrawley.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :scrawley, Scrawley.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "scrawley_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
