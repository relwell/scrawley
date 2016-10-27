# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :scrawley,
  ecto_repos: [Scrawley.Repo]

config :scrawley, Scrawley.Repo,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]

# https://github.com/chrismccord/phoenix_haml
config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

# Configures the endpoint
config :scrawley, Scrawley.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gGLD+4pBx/ASGjrYVJAVuU1kAJQSvfYd4tAgY6szEbYpYYXONJCL6m/mZ0aCx68K",
  render_errors: [view: Scrawley.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Scrawley.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
