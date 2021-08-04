defmodule PhxApp.Repo.Seeds.UserSeeder do
  alias PhxApp.Repo
  alias PhxApp.Accounts
  alias PhxApp.Accounts.User
  alias PhxApp.Blog.Article

  @path "priv/repo/seeds/json/users.json"

  def seed do
    Repo.delete_all Article
    Repo.delete_all User
    @path
    |> File.read!
    |> Jason.decode!
    |> Enum.map(&Accounts.create_user(Map.put(&1, "password", "password")))
  end
end
