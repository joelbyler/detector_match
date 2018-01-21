# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :detector_match,
  ecto_repos: [DetectorMatch.Repo]

config :detector_match, DetectorMatch.Repo,
  extensions: [{Geo.PostGIS.Extension, library: Geo}]

# Configures the endpoint
config :detector_match, DetectorMatchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WVkhc+0lHYR5dMBwLlY3+voxi5Q4X8SgmS0mAZ9NcSRdbgVv3OXZDQOSLLFWIc8+",
  render_errors: [view: DetectorMatchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DetectorMatch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  providers: [
    identity: { Ueberauth.Strategy.Identity, [
        callback_methods: ["POST"],
        uid_field: :email,
        nickname_field: :email,
        request_path: "/session/new",
        callback_path: "/session/identity/callback",
      ]}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
