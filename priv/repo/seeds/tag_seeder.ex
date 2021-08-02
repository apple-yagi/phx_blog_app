defmodule PhxApp.Repo.Seeds.TagSeeder do
  alias PhxApp.Repo
  alias PhxApp.Blog
  alias PhxApp.Blog.Tag

  @path "priv/repo/seeds/json/tags.json"

  def seed do
    Repo.delete_all Tag
    @path
    |> File.read!
    |> Jason.decode!
    |> Enum.map(&Blog.create_tag(&1))
  end
end
