defmodule PhxAppWeb.Web.PageController do
  use PhxAppWeb, :controller

  action_fallback PhxAppWeb.Web.FallbackController

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
