# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :openchat_elixir, OpenchatElixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EE8qdB6gmakMAWRzO9P/PO+qB10GgFqlmTTiKpHA91B9QsKeatU7O9F4ChSy9l/k",
  render_errors: [view: OpenchatElixirWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: OpenchatElixir.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
