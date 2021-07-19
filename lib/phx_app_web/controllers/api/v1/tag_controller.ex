defmodule PhxAppWeb.Api.V1.TagController do
  use PhxAppWeb, :controller

  alias PhxApp.Accessories
  alias PhxApp.Accessories.Tag

  action_fallback PhxAppWeb.Api.Error.FallbackController

  def index(conn, _params) do
    tags = Accessories.list_tags()
    render(conn, "index.json", tags: tags)
  end

  @spec create(any, map) :: any
  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Accessories.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> render("show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Accessories.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Accessories.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Accessories.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Accessories.get_tag!(id)

    with {:ok, %Tag{}} <- Accessories.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
