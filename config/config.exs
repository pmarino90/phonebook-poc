# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phonebook,
  ecto_repos: [Phonebook.Repo]

# Configures the endpoint
config :phonebook, PhonebookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CmMD9nYXCzoOW9xHX091bTyntqtB9DnE4FHjoOT0xbngz3cdxDbF9gFW0Bz62njq",
  render_errors: [view: PhonebookWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Phonebook.PubSub,
  live_view: [signing_salt: "VR7urGPS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
