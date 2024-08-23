defmodule TestShop.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :logger.add_handler(:my_sentry_handler, Sentry.LoggerHandler, %{
      config: %{metadata: [:file, :line]}
    })

    children = [
      TestShopWeb.Telemetry,
      TestShop.Repo,
      {DNSCluster, query: Application.get_env(:test_shop, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TestShop.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TestShop.Finch},
      # Start a worker by calling: TestShop.Worker.start_link(arg)
      # {TestShop.Worker, arg},
      # Start to serve requests, typically the last entry
      TestShopWeb.Endpoint,
      ShopifyAPI.Supervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestShop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestShopWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
