defmodule PhxAppWeb.LayoutView do
  use PhxAppWeb, :view
  alias PhxApp.Auth.Guardian

  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
