defmodule PhxApp.Repo.Seeds.ArticleSeeder do
  import Ecto.Query, warn: false
  alias PhxApp.Repo
  alias PhxApp.Blog
  alias PhxApp.Blog.Article
  alias PhxApp.Accounts.User
  alias PhxApp.Blog.Tag

  @path "priv/repo/seeds/json/articles.json"
  @user_query from u in User,
      limit: 1

  def seed do
    Repo.delete_all Article
    @path
    |> File.read!
    |> Jason.decode!
    |> Enum.map(&Blog.create_article(&1, Repo.all(@user_query) |> List.first))
  end
end
