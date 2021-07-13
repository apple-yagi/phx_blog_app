defmodule PhxAppWeb.LayoutView do
  use PhxAppWeb, :view
  alias PhxApp.Accounts.Guardian
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
