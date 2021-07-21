defmodule PhxAppWeb.Api.V1.UserView do
  use PhxAppWeb, :view
  alias PhxAppWeb.Api.V1.UserView
  alias PhxAppWeb.Api.V1.ArticleView

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
    |> Map.put_new(:articles, render_many(user.articles, ArticleView, "article.json"))
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      createdAt: user.inserted_at,
      updatedAt: user.updated_at
    }
  end

  def render("list_user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      createdAt: user.inserted_at
    }
  end
end
