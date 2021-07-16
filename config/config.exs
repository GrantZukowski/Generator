# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :generator,
  ecto_repos: [Generator.Repo]

# Configures the endpoint
config :generator, GeneratorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7PtgLfH5HP36d2Ng5L3/YI5fz5/9WunYNW/vx5u0gY7MQQkDgmqC7soq+kPtwh5B",
  render_errors: [view: GeneratorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Generator.PubSub,
  live_view: [signing_salt: "I8+g9f4y"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
