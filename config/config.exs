# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :castanhal_fest_api,
  ecto_repos: [CastanhalFestApi.Repo]

# Configures the endpoint
config :castanhal_fest_api, CastanhalFestApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CastanhalFestApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CastanhalFestApi.PubSub,
  live_view: [signing_salt: "ieprbviu"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :castanhal_fest_api, CastanhalFestApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :castanhal_fest_api, CastanhalFestApiWeb.Auth.Guardian,
  issuer: "castanhal_fest_api",
  secret_key: "sB1/GQHfjeS228jAUteJ4Mxk0HxQe/p8uyLtwoHskp35POgX8lLtC3eYMqnzGWG9"

config :castanhal_fest_api, CastanhalFestApi.Uploader,
  aws_access_key: {:system, "AWS_ACCESS_KEY_ID", nil},
  secret_access_key: {:system, "AWS_SECRET_ACCESS_KEY", nil},
  bucket_name: {:system, "BUCKET_NAME", nil},
  region: {:system, "REGION", nil}

config :castanhal_fest_api, CastanhalFestApi.PushNotifications,
  onesignal_id: {:system, "ONESIGNAL_ID", nil},
  onesignal_key: {:system, "ONESIGNAL_KEY", nil}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

if File.exists?("config/local.exs"), do: import_config("local.exs")
