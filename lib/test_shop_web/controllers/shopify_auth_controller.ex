defmodule TestShopWeb.ShopifyAuthController do
  use TestShopWeb, :controller

  def post_install(conn, _params) do
    redirect(conn, to: "/")
  end

  def run_app(conn, _params) do
    redirect(conn, to: "/")
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
