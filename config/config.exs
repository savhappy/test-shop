# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :test_shop,
  ecto_repos: [TestShop.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :test_shop, TestShopWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: TestShopWeb.ErrorHTML, json: TestShopWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: TestShop.PubSub,
  live_view: [signing_salt: "HEkzq3Ou"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :test_shop, TestShop.Mailer, adapter: Swoosh.Adapters.Local

config :shopify_api, ShopifyAPI.Authorizer,
  uri: "https://test-shop-morning-breeze-997.fly.dev",
  post_install: {TestShopWeb.ShopifyAuthController, :post_install},
  run_app: {TestShopWeb.ShopifyAuthController, :run_app}

# config :shopify,
#   client_id: "becff871deb500ecc7f00cc2737a3e3c",
#   client_secret: "5c48c2de9aa822d7935ff5b390071f77"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  test_shop: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  test_shop: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
