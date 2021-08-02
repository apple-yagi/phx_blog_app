defmodule PhxApp.Repo.Seeds.UserSeeder do
  alias PhxApp.Repo
  alias PhxApp.Accounts
  alias PhxApp.Accounts.User

  @path "priv/repo/seeds/json/users.json"

  def seed do
    Repo.delete_all User
    @path
    |> File.read!
    |> Jason.decode!
    |> Enum.map(&Accounts.create_user(&1))
  end
end
