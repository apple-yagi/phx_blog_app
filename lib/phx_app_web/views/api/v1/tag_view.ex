defmodule PhxAppWeb.Api.V1.TagView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.TagView
  alias PhxAppWeb.Api.V1.ArticleView

  def render("index.json", %{tags: tags}) do
    render_many(tags, TagView, "tag.json")
  end

  def render("show.json", %{tag: tag}) do
    render_one(tag, TagView, "tag.json")
    |> Map.put_new(:articles, render_many(tag.articles, ArticleView, "list_article.json"))
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id, name: tag.name, displayName: tag.display_name, iconPath: tag.icon_path}
  end
end
