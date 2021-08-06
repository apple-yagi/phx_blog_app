defmodule PhxAppWeb.Api.V1.ArticleView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.ArticleView
  alias PhxAppWeb.Api.V1.UserView
  alias PhxAppWeb.Api.V1.TagView

  def render("index.json", %{articles: articles, count: count}) do
    %{count: count}
    |> Map.put_new(:articles, render_many(articles, ArticleView, "list_article.json"))
  end

  def render("show.json", %{article: article}) do
    render_one(article, ArticleView, "article.json")
    |> Map.put_new(:user, render_one(article.user, UserView, "user.json"))
    |> Map.put_new(:tags, render_many(article.tags, TagView, "tag.json"))
  end

  def render("article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
      content: article.content,
      thumbnail_url: article.thumbnail_url,
      createdAt: article.inserted_at,
      updatedAt: article.updated_at
    }
  end

  def render("list_article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
      thumbnail_url: article.thumbnail_url,
      createdAt: article.inserted_at
    }
    |> Map.put_new(:user, render_one(article.user, UserView, "list_user.json"))
    |> Map.put_new(:tags, render_many(article.tags, TagView, "tag.json"))
  end
end
