defmodule PhxAppWeb.Api.V1.TagView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.TagView

  def render("index.json", %{tags: tags}) do
    render_many(tags, TagView, "tag.json")
  end

  def render("show.json", %{tag: tag}) do
    render_one(tag, TagView, "tag.json")
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id, name: tag.name, icon_path: tag.icon_path}
  end
end
