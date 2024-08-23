defmodule TestShop.Repo do
  use Ecto.Repo,
    otp_app: :test_shop,
    adapter: Ecto.Adapters.Postgres
end
