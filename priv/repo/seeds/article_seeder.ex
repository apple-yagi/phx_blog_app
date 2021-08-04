defmodule PhxApp.Repo.Seeds.ArticleSeeder do
  alias PhxApp.Repo
  alias PhxApp.Blog
  alias PhxApp.Blog.Article
  alias PhxApp.Accounts.User

  @articles_path "priv/repo/seeds/json/articles.json"
  @users_path "priv/repo/seeds/json/users.json"

  def seed do
    @articles_path
    |> File.read!
    |> Jason.decode!
    |> Enum.map(&Blog.create_article(&1, get_user))
  end

  defp get_user do
    first_user = @users_path
    |> File.read!
    |> Jason.decode!
    |> List.first

    Repo.get_by!(User, name: first_user["name"])
  end
end
