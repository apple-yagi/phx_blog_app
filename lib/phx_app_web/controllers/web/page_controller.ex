defmodule PhxAppWeb.Web.PageController do
  use PhxAppWeb, :controller

  action_fallback PhxAppWeb.Web.FallbackController

  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
