defmodule TestShopWeb.ShopifyAuthController do
  use TestShopWeb, :controller
  use ShopifexWeb.AuthController

  # Optional: Override callbacks to customize behavior
  @impl true
  def after_install(conn, shop, _state) do
    # Custom logic after installation
    IO.puts("Installation completed for shop #{shop.url}")

    # Redirect to your custom URL
    redirect(conn, external: "https://yourstandaloneapp.com/dashboard")
  end

  # def callback(conn, %{"code" => code, "shop" => shop_name}) do
  #   session = Shopify.session(shop_name)

  #   case OAuth.request_token(session, code) do
  #     {:ok, %Shopify.Response{data: oauth}} ->
  #       # Store the access token as needed and establish a session
  #       Shopify.session(shop_name, oauth.access_token)

  #       # Redirect to a dashboard or main app page
  #       redirect(conn, to: "/")

  #     {:error, error} ->
  #       # Handle error case and perhaps redirect with a message
  #       conn
  #       |> put_flash(:error, "Failed to authenticate with Shopify: #{inspect(error)}")
  #       |> redirect(to: "/")
  #   end
  # end
end
